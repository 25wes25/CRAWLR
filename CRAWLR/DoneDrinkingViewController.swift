//
//  DoneDrinkingViewController.swift
//  CRAWLR
//
//  Created by Mayra Sanchez on 4/21/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Contacts

import Foundation

class DoneDrinkingController: UIViewController{

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
}
    
    @IBAction func OnPressContacts(_ sender: Any) {
        print("i work")
    }
    private func fetchContacts() {
        print("Attempting to fetch contatcs...") //testing
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access", err)
                return
            }
            if granted {
                print("Access granted")
            } else {
               print("Access denied")
            }
            
        }
        
    }

}
