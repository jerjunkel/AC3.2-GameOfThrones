//
//  HeaderTableViewCell.swift
//  AC3.2-GameOfThrones
//
//  Created by Jermaine Kelly on 10/15/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionHeaderTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
