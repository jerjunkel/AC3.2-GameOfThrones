//
//  GameOfThronesTableViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jason Gresh on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GameOfThronesTableViewController: UITableViewController {
    
    
    var episodes = [GOTEpisode]()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 20
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let season = Season(rawValue: section) else { return 0 }
        let data = bySeason(season: season)
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)

        guard let season = Season(rawValue: indexPath.section) else {
            return cell
        }
        let data = bySeason(season: season)
        let episode = data[indexPath.row]
        if let episodecell = cell as? EpisodeTableViewCell{
            
        episodecell.episodeTitleLabel.text = String(episode.number) + ". " + episode.name
        episodecell.episodeAirDateLabel.text = "AirDate: \(episodeDate(for: episode.airdate))"
            //episodecell.episodeNumberLabel.text =
        }
        
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
//        
//        headerCell.backgroundColor = .red
//        //headerCell.sectionHeaderTitle.text = "test"
//       
//        
//        return headerCell
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let season = Season(rawValue: section) else { return " "}
        
//        if section == 0{
//            return "Just test"
//        }
        
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


       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let episodeVC = segue.destination as? EpisodeViewController{
            if segue.identifier == "toEpisodeView"{
                if let selectedIndex = tableView.indexPathForSelectedRow{
                    guard let season = Season(rawValue: selectedIndex.section)else { return }
                        let data = bySeason(season: season)
                    episodeVC.episode = data[selectedIndex.row]
                }
                
            }
        }
    }
    

}
