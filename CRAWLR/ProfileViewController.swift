//
//  ProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 3/1/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
           
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    
    var usernameUpdate:String!{
        willSet{
            usernameLabel.text =  newValue
        }
    }
    
    var weightUpdate:String!{
        willSet{
            weightLabel.text = newValue
        }
    }
    
    var ageUpdate:String!{
        willSet{
            ageLabel.text = newValue
        }
    }
    
    var heightUpdate:String!{
        willSet{
            heightLabel.text = newValue
        }
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameLabel.text = "wesley"
        weightLabel.text = "170 lb"
        ageLabel.text = "22"
        heightLabel.text = "6'2''"

    }
    
    @IBAction func EditProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "Edit", sender: self)
        
    }
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "Edit" {
            let name = segue.destination as! EditProfileViewController
            name.usernameText = usernameLabel.text
            
            let age = segue.destination as? EditProfileViewController
            age?.ageText = ageLabel.text
            
            let weight = segue.destination as? EditProfileViewController
            weight?.weightText = weightLabel.text
            
            let height = segue.destination as? EditProfileViewController
            height?.heightText = heightLabel.text
 
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EditProfileViewController{
            usernameUpdate = sourceViewController.usernameText
        }
        
        
        if let sourceViewController = sender.source as? EditProfileViewController{
            ageUpdate = sourceViewController.ageText
        }
        
        
        if let sourceViewController = sender.source as? EditProfileViewController{
            weightUpdate = sourceViewController.weightText
        }
        
        
        if let sourceViewController = sender.source as? EditProfileViewController{
            heightUpdate = sourceViewController.heightText
        }
         
    }
    
 
}

