//
//  SettingsViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 4/26/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

        
    @IBAction func onLogOutPress(_ sender: Any) {
        do {
            try! Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } 
        
    }
    

}
