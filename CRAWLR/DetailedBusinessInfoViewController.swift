//
//  DetailedBusinessInfoViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/24/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation
import UIKit

class DetailedBusinessInfoViewController: UIViewController {

    var selectedBusinessID: String?
    var selectedBusinessDistance: Double?
    var business: Business?

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var status: DesignableLabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var stateZip: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    var website = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        let onDidRecieveBusiness: (Business?) -> Void = { business in
            if let business = business{
                self.business = business
                self.updateViews(business: business)
            }
        }
        
        if let businessID = selectedBusinessID{
            ApiHelper.instance.getBusiness(id: businessID, callback: onDidRecieveBusiness)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func updateViews(business: Business) {
        
        if let imageUrlString = business.photos?[0] {
            if let imageUrl = URL(string: imageUrlString){
                if let imageData = try? Data(contentsOf: imageUrl){
                    businessImage.image = UIImage(data: imageData)
                }
            }
        }
        
        if let open = business.hours?[0].is_open_now {
            status.isHidden = false
            if open {
                status.text = "Open"
                status.textColor = UIColor.green
                status.borderColor = UIColor.green
            } else {
                status.text = "Closed"
                status.textColor = UIColor.red
                status.borderColor = UIColor.red
            }
        } else {
            status.isHidden = true
        }
              
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        var newDayOfWeek: Int
        if let dayOfWeek = components.weekday{
            if dayOfWeek > 1 {
                newDayOfWeek = (dayOfWeek - 2) % 6
            } else {
                newDayOfWeek = 6
            }
            
            var startTimeStr: String = "00:00AM"
            var endTimeStr: String = "00:00AM"
            if let hoursLength = business.hours?[0].open?.count{
                for i in 0..<hoursLength{
                    if(newDayOfWeek == business.hours?[0].open?[i].day){
                        if let start = business.hours?[0].open?[i].start {
                            let startTime = Int(start) ?? 0
                            startTimeStr = self.convertTime(time: startTime)
                        }
                        if let end = business.hours?[0].open?[i].end{
                            let endTime = Int(end) ?? 0
                            endTimeStr = self.convertTime(time: endTime)
                        }
                        hours.text = startTimeStr + " - " + endTimeStr
                    }
                }
            }
            
        }
                
                
        let businessAddress = business.location
        address.text = (businessAddress?.address1 ?? "") + ","
        city.text = (businessAddress?.city ?? "")  + ","
        stateZip.text =  (businessAddress?.state ?? "") + " " + (businessAddress?.zip_code ?? "")
        
        if let phoneNumber = business.display_phone {
            phoneNum.text = phoneNumber
        }
        
        if let distanceAway = selectedBusinessDistance {
            let distanceMiles = distanceAway * 0.000621371
           distance.text = String(format: "%.2f", distanceMiles) + " miles away"
        }
        
        let rating = business.rating
        switch rating {
            case 0:
                ratingImage.image = UIImage(named: "yelp0stars")
            case 1:
                ratingImage.image = UIImage(named: "yelp1star")
            case 1.5:
                ratingImage.image = UIImage(named: "yelp1.5stars")
            case 2:
                ratingImage.image = UIImage(named: "yelp2stars")
            case 2.5:
                ratingImage.image = UIImage(named: "yelp2.5stars")
            case 3:
                ratingImage.image = UIImage(named: "yelp3stars")
            case 3.5:
                ratingImage.image = UIImage(named: "yelp3.5stars")
            case 4:
                ratingImage.image = UIImage(named: "yelp4stars")
            case 4.5:
                ratingImage.image = UIImage(named: "yelp4.5stars")
            case 5:
                ratingImage.image = UIImage(named: "yelp5stars")
            default:
                break
        }
        
        if let nameInfo = business.name {
            name.text = nameInfo
        }
        
    }
    
    func convertTime(time: Int) -> String{
        var timeInt: Int
        var timeStr: String
        var tempStr: String
        if time >= 1200 {
            timeInt = time - 1200
            if timeInt < 10 {
                timeStr = "12:0" + String(timeInt) + "PM"
            } else if timeInt < 60 {
                timeStr = "12:" + String(timeInt) + "PM"
            } else if timeInt < 959{
                tempStr = String(timeInt)
                let tempSubstringHr =  tempStr[tempStr.startIndex]
                let tempSubstringMin = tempStr.suffix(2)
                timeStr = String(tempSubstringHr) + ":" + String(tempSubstringMin) + "PM"
            } else {
                tempStr = String(timeInt)
                let index = tempStr.index(tempStr.startIndex, offsetBy: 2)
                let tempSubstringHr = tempStr[..<index]
                let tempSubstringMin = tempStr.suffix(2)
                timeStr = String(tempSubstringHr) + ":" + String(tempSubstringMin) + "PM"
            }
        } else{
            if time < 10 {
                timeStr = "12:0" + String(time) + "AM"
            } else if time < 60 {
                timeStr = "12:" + String(time) + "AM"
            } else if time < 959{
                tempStr = String(time)
                let tempSubstringHr =  tempStr[tempStr.startIndex]
                let tempSubstringMin = tempStr.suffix(2)
                timeStr = String(tempSubstringHr) + ":" + String(tempSubstringMin) + "AM"
            } else {
                tempStr = String(time)
                let index = tempStr.index(tempStr.startIndex, offsetBy: 2)
                let tempSubstringHr = tempStr[..<index]
                let tempSubstringMin = tempStr.suffix(2)
                timeStr = String(tempSubstringHr) + ":" + String(tempSubstringMin) + "AM"
            }
        
        }
        return timeStr
    }
    
    @IBAction func onMapButtonPressed(_ sender: Any) {
        let address = self.business?.location?.address1 ?? ""
        let city = self.business?.location?.city ?? ""
        let state = self.business?.location?.state ?? ""
        let zipCode = self.business?.location?.zip_code ?? ""
        var myAddress: String = " "
        myAddress = address + "," + city + "," + state + "," + zipCode
        var addressURL: String = " "
        addressURL = "http://maps.apple.com/?address=" + myAddress
        addressURL = addressURL.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: addressURL) {
            UIApplication.shared.open(url)
        } else {
            print("could not open url, it was nil")
        }
                
        
    }
    
    @IBAction func onWebsiteButtonPressed(_ sender: Any) {
        if let websiteInfo = self.business?.url {
            if let url = URL(string: websiteInfo) {
                UIApplication.shared.open(url)
            }
            
        }
    }

}


