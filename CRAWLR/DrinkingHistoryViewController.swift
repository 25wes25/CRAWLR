//
//  DrinkingHistoryViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/21/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [Drink]()
}

class DrinkingHistoryViewController: UITableViewController {
    
    var user: User?
    var userDrinks: [Drink]?
    var tableViewData = [cellData]()
    var days = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onDidGetUserDrinks: ([Drink]?) -> Void = { drinks in
            self.userDrinks = drinks
            
            if let userDrinkList = self.userDrinks {
                self.populateCells(userDrinkList: userDrinkList)
            }
            self.tableView.reloadData()
        }
        
        if let userID = self.user?._id {
            ApiHelper.instance.getUserDrinks(id: userID, callback: onDidGetUserDrinks)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell",
                                  for: indexPath) as! DayCell

            // Fetch the data for the row.
            let theDay = tableViewData[indexPath.section].title
                 
            // Configure the cell’s contents with data from the fetched object.
            dayCell.day?.text = theDay
            if tableViewData[indexPath.section].opened == true{
                dayCell.picture?.image = UIImage(systemName: "chevron.up")
            } else {
                dayCell.picture?.image = UIImage(systemName: "chevron.down")
            }
                 
            return dayCell
            
        } else {
            let drinkCell = tableView.dequeueReusableCell(withIdentifier: "drinkCell",
            for: indexPath) as! DrinkCell

            // Fetch the data for the row.
            let theDrink = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                            
           // Configure the cell’s contents with data from the fetched object.
            
            drinkCell.drinkName?.text = theDrink.beverage?.uppercased()
            
            // Time Formatting
            if let drinkTime = theDrink.date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                if let drinkTimeFormatted = formatter.date(from: drinkTime) {
                    formatter.dateFormat = "h:mma"
                    let drinkStringTimeFormatted = formatter.string(from: drinkTimeFormatted)
                    drinkCell.time?.text = drinkStringTimeFormatted
                }
            }
            return drinkCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    func populateCells (userDrinkList: [Drink]) {
        var drinkList = userDrinkList
        drinkList.sort {
            $0.date! > $1.date!
        }
        
        for drink in drinkList {
            if let drinkDate = drink.date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                if let drinkDateFormatted = formatter.date(from: drinkDate) {
                    formatter.dateFormat = "MMM d, yyyy"
                    let drinkStringDateFormatted = formatter.string(from: drinkDateFormatted)
                    if !self.days.contains(drinkStringDateFormatted){
                        self.days.append(drinkStringDateFormatted)
                    }
                }
            }
        }
        
        var sectionData = [Drink]()
        for day in self.days {
            if let userDrinkList = self.userDrinks{
                for drink in userDrinkList {
                    if let drinkDate = drink.date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                        if let drinkDateFormatted = formatter.date(from: drinkDate) {
                            formatter.dateFormat = "MMM d, yyyy"
                            let drinkStringDateFormatted = formatter.string(from: drinkDateFormatted)
                            if drinkStringDateFormatted == day {
                                sectionData.append(drink)
                            }
                        }
                    }
                }
            }
            
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            let currentDateFormatted = formatter.string(from: currentDate)
            if day == currentDateFormatted {
                self.tableViewData.append(cellData(opened: false, title: "TODAY", sectionData: sectionData))
            } else {
                self.tableViewData.append(cellData(opened: false, title: day.uppercased(), sectionData: sectionData))
            }
            sectionData.removeAll()
        }
    }
}
