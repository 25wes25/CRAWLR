//
//  EditProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    var usernameText : String? = ""
    var weightText : String? = ""
    var ageText : String? = ""
    var heightText : String? = ""
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextField.text = usernameText
        weightTextField.text = weightText
        ageTextField.text = ageText
        heightTextField.text = heightText
        
        usernameTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        heightTextField.delegate = self
 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        usernameText = usernameTextField.text
        weightText = weightTextField.text
        ageText = ageTextField.text
        heightText = heightTextField.text
    }
}


