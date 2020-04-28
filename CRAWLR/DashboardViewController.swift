//
//  DashboardViewController.swift
//  CRAWLR
//
//  Created by Mayra Sanchez on 2/27/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var shotsButton: UIButton!
    @IBOutlet var shotsLabel: UILabel!
    @IBOutlet var shotsUnderlineView: UIView!

    @IBOutlet var cocktailsButton: UIButton!
    @IBOutlet var cocktailsLabel: UILabel!
    @IBOutlet var cocktailsUnderlineView: UIView!
    
    @IBOutlet var otherButton: UIButton!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var otherUnderlineView: UIView!
    
    var selectedDrink: String?
    var selectedType = "shots"
    var user: User?
    
    var shots = ["TEQUILA", "WHISKEY", "VODKA", "GIN", "RUM", "MOONSHINE"];
    var cocktails = ["MARGARITA", "COSMO", "SCREWDRIVER", "MIMOSA", "WINE", "CHAMPAIGN"];
    var other = ["WHITE CLAW", "COORS", "CORONA", "HEINEKEN", "805", "GUINNESS"];

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.selectedType == "shots" {
            return self.shots.count
        } else if self.selectedType == "cocktails" {
            return self.cocktails.count
        } else if self.selectedType == "other" {
            return self.other.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCollectionCell", for: indexPath) as? DashboardCollectionCell {
            if self.selectedType == "shots" {
                cell.drinkImageView.image = UIImage(named: self.shots[indexPath.row].lowercased() + "Icon")
                cell.drinkLabel.text = self.shots[indexPath.row];
            } else if self.selectedType == "cocktails" {
                cell.drinkImageView.image = UIImage(named: self.cocktails[indexPath.row].lowercased() + "Icon")
                cell.drinkLabel.text = self.cocktails[indexPath.row];
            } else if self.selectedType == "other" {
                cell.drinkImageView.image = UIImage(named: self.other[indexPath.row].lowercased() + "Icon")
                cell.drinkLabel.text = self.other[indexPath.row];
            }
            cell.layer.borderColor = CGColor.init(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.layer.borderWidth = 2
            cell.layer.cornerRadius = 15
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedType == "shots" {
            self.selectedDrink = self.shots[indexPath.row]
        } else if self.selectedType == "cocktails" {
            self.selectedDrink = self.cocktails[indexPath.row]
        } else if self.selectedType == "other" {
            self.selectedDrink = self.other[indexPath.row]
        }
        guard let drinkTrackerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrinkTrackerViewController") as? DrinkTrackerViewController else {return}
        drinkTrackerViewController.drink = self.selectedDrink
        drinkTrackerViewController.drinkType = self.selectedType
        drinkTrackerViewController.userId = self.user?._id
        self.present(drinkTrackerViewController, animated: true)
        drinkTrackerViewController.yesButtonEvent = { drinkTrackerViewController.dismiss(animated: true) }
        drinkTrackerViewController.noButtonEvent = { drinkTrackerViewController.dismiss(animated: true) }
    }
    
    @IBAction func onPressShotsButton(_ sender: Any) {
        self.selectedType = "shots"
        self.collectionView.reloadData()
        self.shotsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.shotsUnderlineView.isHidden = false;
        self.cocktailsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.cocktailsUnderlineView.isHidden = true;
        self.otherLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.otherUnderlineView.isHidden = true;
    }
    
    @IBAction func onPressCocktailsButton(_ sender: Any) {
        self.selectedType = "cocktails"
        self.collectionView.reloadData()
        self.shotsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.shotsUnderlineView.isHidden = true;
        self.cocktailsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.cocktailsUnderlineView.isHidden = false;
        self.otherLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.otherUnderlineView.isHidden = true;
    }
    
    @IBAction func onPressOtherButton(_ sender: Any) {
        self.selectedType = "other"
        self.collectionView.reloadData()
        self.shotsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.shotsUnderlineView.isHidden = true;
        self.cocktailsLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 0.5)
        self.cocktailsUnderlineView.isHidden = true;
        self.otherLabel.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 252/255, alpha: 1)
        self.otherUnderlineView.isHidden = false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DrinkViewController
        {
            let vc = segue.destination as? DrinkViewController
            vc?.title = self.selectedDrink
            vc?.drink = self.selectedDrink
            if self.selectedType == "shots" {
                vc?.drinkType = "SHOT"
            } else if self.selectedType == "cocktails" {
                vc?.drinkType = "COCKTAIL"
            } else if self.selectedType == "other" {
                vc?.drinkType = "BEVERAGE"
            }
        }
    }
}
