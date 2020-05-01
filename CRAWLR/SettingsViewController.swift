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
        do
        {
            try Auth.auth().signOut()

            UserDefaults.standard.set(false, forKey: "isLogin")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.synchronize()

        }
        catch 
        {
            let alertController = UIAlertController.init(title: "Error", message: "Localized Description", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
        }
        
        self.performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
    }
    

}
