//
//  GOTMainViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jermaine Kelly on 10/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GOTMainViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var episodes = [GOTEpisode]()
    var seasonSelected = 0
    
    @IBOutlet weak var episodeTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    @IBAction func changeSeasons(_ sender: UIButton) {
        seasonSelected = Int(sender.currentTitle!)! - 1
//        sender.isHighlighted = true
        reloadTableView()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let season = Season(rawValue: seasonSelected) else { return 0 }
        let data = bySeason(season: season)
        return data.count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let season = Season(rawValue: seasonSelected) else { return " "}
        
        
        switch season{
        case .First:
            return "Season 1"
        case .Second:
            return "Season 2"
        case .Third:
            return "Season 3"
        case .Fourth:
            return "Season 4"
        case .Fifth:
            return "Season 5"
        case .Sixth:
            return "Season 6"
        }
        
    
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        
        guard let season = Season(rawValue: seasonSelected) else {
            return cell
        }
        
        let data = bySeason(season: season)
        let episode = data[indexPath.row]
        
        if let episodecell = cell as? EpisodeTableViewCell{
            episodecell.episodeTitleLabel.text = String(episode.number) + ". " + episode.name
            episodecell.episodeAirDateLabel.text = "AirDate: \(episodeDate(for: episode.airdate))"
        }

        return cell
    }
    
    
    
    
    // MARK: - Utilities
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "got", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
            let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary else {
                return
        }
        
        if let episodes = dict?.value(forKeyPath: "_embedded.episodes") as? [[String:Any]] {
            for epDict in episodes {
                if let ep = GOTEpisode(withDict: epDict) {
                    self.episodes.append(ep)
                }
            }
        }
        
        //dump(episodes)
    }
    
    //returns filter data by season
    func bySeason(season: Season) -> [GOTEpisode]{
        let filter: (GOTEpisode) -> Bool
        
        switch season{
        case .First:
            filter = {$0.season == 1}
        case .Second:
            filter = {$0.season == 2}
        case .Third:
            filter = {$0.season == 3}
        case .Fourth:
            filter = {$0.season == 4}
        case .Fifth:
            filter = {$0.season == 5}
        case .Sixth:
            filter = {$0.season == 6}
        }
        
        let filteredEpisodes = episodes.filter(filter).sorted{$0.number < $1.number}
        return filteredEpisodes
        
    }
    
    //Converts string date format "yyyy-mm-dd"
    func episodeDate(for date:String)->String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        guard let dateObj = dateFormater.date(from: date) else { return ""}
        dateFormater.dateStyle = .medium
        return dateFormater.string(from: dateObj)
        
        
        
    }
    
    //reloads the tableview
    func reloadTableView(){
        DispatchQueue.main.async{
            self.episodeTableView.reloadData()
        }
    }
    

    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let episodeVC = segue.destination as? EpisodeViewController{
            if segue.identifier == "toEpisodeView"{
                if let selectedIndex = self.episodeTableView.indexPathForSelectedRow{
                    guard let season = Season(rawValue: seasonSelected)else { return }
                    let data = bySeason(season: season)
                    episodeVC.episode = data[selectedIndex.row]
                }
                
            }
        }
    }
}
