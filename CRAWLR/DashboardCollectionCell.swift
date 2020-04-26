//
//  DashboardCollectionCell.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DashboardCollectionCell: UICollectionViewCell {
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
