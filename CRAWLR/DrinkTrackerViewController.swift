//
//  DrinkTrackerViewController.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/27/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DrinkTrackerViewController: UIViewController {
    @IBOutlet var trackerView: UIView!
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var confirmationLabel: UILabel!
    
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var drink: String?
    var drinkType: String?
    var userId: String?
    
    var yesButtonEvent: (()->Void)!
    var noButtonEvent: (()->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateView()
        if let drink = self.drink {
            self.drinkImageView.image = UIImage(named: drink.lowercased() + "Icon")
            if self.drinkType == "shots" {
                self.confirmationLabel.text = "CONFIRM " + drink + " SHOT?"
            } else {
                self.confirmationLabel.text = "CONFIRM " + drink + "?"
            }
        }
        self.trackerView.borderColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.trackerView.borderWidth = 1
        self.yesButton.borderColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.yesButton.borderWidth = 1
        self.noButton.borderColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.noButton.borderWidth = 1
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func animateView() {
        self.trackerView.alpha = 0;
        self.trackerView.frame.origin.y = self.trackerView.frame.origin.y
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.trackerView.alpha = 1.0;
            self.trackerView.frame.origin.y = self.trackerView.frame.origin.y
        })
    }
    
    @IBAction func onPressYesButton(_ sender: Any) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        var drinkRecord = Drink()
        drinkRecord.amount = 1
        drinkRecord.beverage = self.drink?.lowercased()
        drinkRecord.date = formatter.string(from: currentDate)
        drinkRecord.userId = self.userId
        
        let onDidTrackDrink: (Drink?) -> Void = { drink in
            self.yesButtonEvent()
        }
        ApiHelper.instance.trackDrink(drink: drinkRecord, callback: onDidTrackDrink)
    }
    
    @IBAction func onPressNoButton(_ sender: Any) {
        self.noButtonEvent()
    }
}
