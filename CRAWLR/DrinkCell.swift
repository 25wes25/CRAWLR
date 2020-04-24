//
//  DrinkCell.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/21/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DrinkCell: UITableViewCell {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
