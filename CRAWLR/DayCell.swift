//
//  DayCell.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/21/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

   
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
