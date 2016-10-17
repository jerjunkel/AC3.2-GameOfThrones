//
//  EpisodeTableViewCell.swift
//  AC3.2-GameOfThrones
//
//  Created by Jermaine Kelly on 10/14/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
