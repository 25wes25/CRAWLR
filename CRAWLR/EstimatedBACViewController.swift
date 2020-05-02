//
//  EstimatedBACViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/19/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class EstimatedBACViewController: UIViewController {
    
    var user: User?
    var userDrinks: [Drink]?
    @IBOutlet weak var bacLevelLabel: UILabel!
    @IBOutlet weak var legallyLabel: UILabel!
    @IBOutlet weak var intoxicatedLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var arrowImageSober: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let onDidGetUserDrinks: ([Drink]?) -> Void = { drinks in
            
            if drinks?.count == 0 {
                self.displaySoberView()
            } else {
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy"
                let currentDateFormatted = formatter.string(from: currentDate)
                if let drinkList = drinks {
                    for drink in drinkList {
                        if let drinkDate = drink.date {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                            if let drinkDateFormatted = formatter.date(from: drinkDate) {
                                formatter.dateFormat = "MMM d, yyyy"
                                let drinkStringDateFormatted = formatter.string(from: drinkDateFormatted)
                                if drinkStringDateFormatted == currentDateFormatted {
                                    self.displayDrunkView()
                                } else {
                                    self.displaySoberView()
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if let userID = self.user?._id {
            ApiHelper.instance.getUserDrinks(id: userID, callback: onDidGetUserDrinks)
        }
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 18)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DrinkingHistoryViewController
        {
            let vc = segue.destination as? DrinkingHistoryViewController
            vc?.user = self.user
        }
    }
    
    func displaySoberView() {
        self.intoxicatedLabel.isHidden = true
        self.arrowImageSober.isHidden = true
        self.arrowImage.isHidden = false
        self.bacLevelLabel.text = " .00"
        self.legallyLabel.text = "Sober"
        
        self.arrowImageSober.layer.removeAllAnimations()
        let hoverSober = CABasicAnimation(keyPath: "position")
        hoverSober.isAdditive = true
        hoverSober.fromValue = NSValue(cgPoint: CGPoint.zero)
        hoverSober.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 320.0))
        hoverSober.autoreverses = false
        hoverSober.duration = 2
        hoverSober.fillMode = .forwards
        hoverSober.isRemovedOnCompletion = false
        self.arrowImage.layer.add(hoverSober, forKey: "hoverDrunkToSober")
    }
    
    func displayDrunkView() {
        self.intoxicatedLabel.isHidden = false
        self.arrowImage.isHidden = true
        self.arrowImageSober.isHidden = false
        self.bacLevelLabel.text = ".08+"
        self.legallyLabel.text = "Legally"
        
        self.arrowImage.layer.removeAllAnimations()
        let hoverDrunk = CABasicAnimation(keyPath: "position")
        hoverDrunk.isAdditive = true
        hoverDrunk.fromValue = NSValue(cgPoint: CGPoint.zero)
        hoverDrunk.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: -340.0))
        hoverDrunk.autoreverses = false
        hoverDrunk.duration = 2
        hoverDrunk.fillMode = .forwards
        hoverDrunk.isRemovedOnCompletion = false
        self.arrowImageSober.layer.add(hoverDrunk, forKey: "hoverSobertoDrunk")
    }
}
