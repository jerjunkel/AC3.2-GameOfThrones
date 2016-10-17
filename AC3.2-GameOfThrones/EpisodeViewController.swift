//
//  EpisodeViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jermaine Kelly on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    var episode: GOTEpisode?

    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTitleLabel.text = episode?.name
        summaryLabel.text = episode?.summary
        getEpisodeImage(for: (episode?.imageUrl)!)
    }


    
    
    func getEpisodeImage(for imageUrl:String){
        guard let url = URL(string: imageUrl) else { return }
        guard let data = try? Data(contentsOf: url) else { return } //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        episodeImage.image = UIImage(data: data)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
