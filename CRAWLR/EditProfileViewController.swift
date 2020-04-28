//
//  EditProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    var user:User?
    var selectedUserID:String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBAction func onSaveButtonPress(_ sender: Any) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextField.text = user?.username
        weightTextField.text = String(Int((user?.weight ?? 0))) + " lb"
        ageTextField.text = String(Int(user?.age ?? 21))
        heightTextField.text = (user?.height ?? "5'5") + "''"
        
        usernameTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        heightTextField.delegate = self
 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


