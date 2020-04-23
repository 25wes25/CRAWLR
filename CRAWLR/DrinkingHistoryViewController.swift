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
    var sectionData = [drink]()
}

struct drink{
    var drinkName = String()
    var time = String()
}

class DrinkingHistoryViewController: UITableViewController {
    
    var tableViewData = [cellData]()
    var days = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        days = ["TONIGHT", "JULY 4th, 2019", "JULY 1st, 2019", "JUNE 29th, 2019"]
        tableViewData = [cellData(opened: false, title: days[0], sectionData: [drink(drinkName: "TEQUILA SHOT", time: "8:57pm"), drink(drinkName: "VODKA SHOT", time: "8:58pm"), drink(drinkName: "BLOODY MARY", time: "9:00pm"), drink(drinkName: "TEQUILA SHOT", time: "9:17pm"), drink(drinkName: "TEQUILA SHOT", time: "10:00pm")]), cellData(opened: false, title: days[1], sectionData: [drink(drinkName: "TEQUILA SHOT", time: "8:57pm"), drink(drinkName: "VODKA SHOT", time: "8:58pm"), drink(drinkName: "BLOODY MARY", time: "9:00pm"), drink(drinkName: "TEQUILA SHOT", time: "9:17pm"), drink(drinkName: "TEQUILA SHOT", time: "10:00pm")]), cellData(opened: false, title: days[2], sectionData: [drink(drinkName: "TEQUILA SHOT", time: "8:57pm"), drink(drinkName: "VODKA SHOT", time: "8:58pm"), drink(drinkName: "BLOODY MARY", time: "9:00pm"), drink(drinkName: "TEQUILA SHOT", time: "9:17pm"), drink(drinkName: "TEQUILA SHOT", time: "10:00pm")]), cellData(opened: false, title: days[3], sectionData: [drink(drinkName: "TEQUILA SHOT", time: "8:57pm"), drink(drinkName: "VODKA SHOT", time: "8:58pm"), drink(drinkName: "BLOODY MARY", time: "9:00pm"), drink(drinkName: "TEQUILA SHOT", time: "9:17pm"), drink(drinkName: "TEQUILA SHOT", time: "10:00pm")])]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        } else{
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell",
                                  for: indexPath) as! DayCell

            // Fetch the data for the row.
            let theDay = tableViewData[indexPath.section].title
                 
            // Configure the cell’s contents with data from the fetched object.
            dayCell.day?.text = theDay
            if tableViewData[indexPath.section].opened == true{
                dayCell.picture?.image = UIImage(systemName: "chevron.up")
            } else{
                dayCell.picture?.image = UIImage(systemName: "chevron.down")
            }
                 
            return dayCell
        } else {
            let drinkCell = tableView.dequeueReusableCell(withIdentifier: "drinkCell",
            for: indexPath) as! DrinkCell

            // Fetch the data for the row.
            let theDrink = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                            
           // Configure the cell’s contents with data from the fetched object.
            drinkCell.drinkName?.text = theDrink.drinkName
            drinkCell.time?.text = theDrink.time
                
           return drinkCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true{
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else{
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }


}
