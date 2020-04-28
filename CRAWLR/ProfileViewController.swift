//
//  ProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 3/1/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var user: User?
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = user?.username
        weightLabel.text = String(Int((user?.weight ?? 120))) + " lb"
        ageLabel.text = String(Int(user?.age ?? 21))
        heightLabel.text = (user?.height ?? "5'5")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let onDidGetUserByID: (User?) -> Void = { user in
            self.user = user
        }
        if let id = self.user?._id {
            ApiHelper.instance.getUserByID(id: id, callback: onDidGetUserByID)
        }
        usernameLabel.text = user?.username
        weightLabel.text = String(Int((user?.weight ?? 120))) + " lb"
        ageLabel.text = String(Int(user?.age ?? 21))
        heightLabel.text = (user?.height ?? "5'5")
    }
    
    @IBAction func EditProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "ProfileToEditProfileSegue", sender: self)
        
    }
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ProfileToEditProfileSegue" {
            let edit = segue.destination as! EditProfileViewController
            edit.user = self.user 
        }
    }
    
    @IBAction func unwindToProfile(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! EditProfileViewController
        // Use data from the view controller which initiated the unwind segue
        let onDidUpdateUser: (User?) -> Void = { user in
            sourceViewController.user = user
            self.user = user
            
        }
        if let user = sourceViewController.user {
            ApiHelper.instance.updateUser(user: user, callback: onDidUpdateUser)
        }
    }
 
}

