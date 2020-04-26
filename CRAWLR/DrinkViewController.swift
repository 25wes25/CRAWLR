//
//  DrinkViewController.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var drinkLabel: UILabel!
    @IBOutlet var drinkTypeLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    var drink: String?
    var drinkType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.drinkLabel.text = self.drink
        self.drinkTypeLabel.text = self.drinkType
        if let drink = self.drink {
            self.drinkImageView.image = UIImage(named: drink.lowercased() + "Icon")
        }
        self.doneButton.layer.borderColor = UIColor.init(red: 0, green: 184, blue: 252, alpha: 1).cgColor
        self.doneButton.layer.borderWidth = 2
        self.doneButton.layer.cornerRadius = 15
    }
    
    @IBAction func onPressSubtractButton(_ sender: Any) {
        if let amountText = self.amountLabel.text {
            if let amount = Int(amountText) {
                if amount > 1 {
                    self.amountLabel.text = String(amount - 1)
                    if amount - 1 == 1 {
                        if let drinkType = self.drinkType {
                            self.drinkTypeLabel.text = drinkType
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onPressAddButton(_ sender: Any) {
        if let amountText = self.amountLabel.text {
            if let amount = Int(amountText) {
                if amount < 10 {
                    self.amountLabel.text = String(amount + 1)
                    if let drinkType = self.drinkType {
                        self.drinkTypeLabel.text = drinkType + "S"
                    }
                }
            }
        }
    }
    
    @IBAction func onPressDoneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
