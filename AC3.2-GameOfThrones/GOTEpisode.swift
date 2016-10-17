//
//  GOTEpisode.swift
//  AC3.2-GameOfThrones
//
//  Created by Jermaine Kelly on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum Season: Int{
    case First  
    case Second
    case Third  
    case Fourth
    case Fifth  
    case Sixth
    
}

class GOTEpisode {
    let name: String
    let number: Int
    let airdate: String
    let season: Int
    let summary: String
    let imageUrl: String
    
    init(name: String, number: Int, airdate: String, season: Int, summary: String, imageUrl:String) {
        self.name = name
        self.number = number
        self.airdate = airdate
        self.season = season
        self.summary = summary
        self.imageUrl = imageUrl
        
    }
    
    convenience init?(withDict dict: [String:Any]) {
        if let name = dict["name"] as? String,
            let number = dict["number"] as? Int,
            let airdate = dict["airdate"] as? String,
            let season = dict["season"] as? Int,
            let summary = dict["summary"] as? String,
            let imageSize = dict["image"] as? [String:String],
            let imageUrl = imageSize["original"]{
            self.init(name: name, number: number, airdate: airdate, season: season, summary:summary, imageUrl:imageUrl)
        }
        else {
            return nil
        }
    }
}
