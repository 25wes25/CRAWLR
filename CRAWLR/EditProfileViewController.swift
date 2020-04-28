//
//  EditProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    var selectedUserID: String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextField.text = user?.username
        weightTextField.text = String(Int((user?.weight ?? 0)))
        ageTextField.text = String(Int(user?.age ?? 21))
        heightTextField.text = (user?.height ?? "5'5")
        
        usernameTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        heightTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification
        , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification
        , object: nil)
 
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
           let userInfo = notification.userInfo!
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)

           var contentInset:UIEdgeInsets = self.scrollView.contentInset
           contentInset.bottom = keyboardFrame.size.height
           scrollView.contentInset = contentInset
       }

       @objc func keyboardWillHide(notification:NSNotification){

           let contentInset:UIEdgeInsets = UIEdgeInsets.zero
           scrollView.contentInset = contentInset
       }
       
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
//    @IBAction func onSaveButtonPress(_ sender: Any) {
//        let onDidUpdateUser: (User?) -> Void = { user in
//            self.user = user
//            //self.performSegue(withIdentifier: "EditProfileToProfileSegue", sender: self)
//        }
//        if let user = self.user {
//            ApiHelper.instance.updateUser(user: user, callback: onDidUpdateUser)
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let username = usernameTextField.text {
            user?.username = username
        }
        
        if let weight = weightTextField.text {
            user?.weight = Double(weight)
        }
        
        if let age = ageTextField.text {
            if let ageDouble = Double(age) {
                if ageDouble >= 21 {
                   user?.age = ageDouble
                } else {
                    ageTextField.text = String(Int(user?.age ?? 21))
                    let alertController = UIAlertController.init(title: "Error", message: "You must be at least 21 to use CRAWLR", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        if let height = heightTextField.text {
            user?.height = height
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


