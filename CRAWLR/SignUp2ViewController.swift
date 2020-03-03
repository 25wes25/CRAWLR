//
//  SignUp2ViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/13/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Firebase

class SignUp2ViewController: UIViewController {
  
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    var email: String = ""
    var password: String = ""
    var validateButtons = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification
        , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification
        , object: nil)
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "USERNAME*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
       ageTextField.attributedPlaceholder = NSAttributedString(string: "AGE*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
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
    
    @IBAction func onPressMaleButton(_ sender: UIButton) {
        if sender.isSelected {
            validateButtons = false
            sender.isSelected = false
            femaleButton.isSelected = false
            otherButton.isSelected = false
        } else{
            validateButtons = true
            sender.isSelected = true
            femaleButton.isSelected = false
            otherButton.isSelected = false
        }
    }
    
    @IBAction func onPressFemaleButton(_ sender: UIButton) {
        if sender.isSelected {
            validateButtons = false
            sender.isSelected = false
            maleButton.isSelected = false
            otherButton.isSelected = false
        } else{
            validateButtons = true
            sender.isSelected = true
            maleButton.isSelected = false
            otherButton.isSelected = false
        }
    }
    
    @IBAction func onPressOtherButton(_ sender: UIButton) {
        if sender.isSelected {
            validateButtons = false
            sender.isSelected = false
            femaleButton.isSelected = false
            maleButton.isSelected = false
        } else{
            validateButtons = true
            sender.isSelected = true
            femaleButton.isSelected = false
            maleButton.isSelected = false
        }
    }
    
    @IBAction func OnPressCreateAccount(_ sender: Any) {
        let age: Int? = Int(ageTextField.text!)
        if(usernameTextField.text == "" || ageTextField.text == "" || validateButtons == false){
            let alertController = UIAlertController.init(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if(age ?? 0 < 21){
            let alertController = UIAlertController.init(title: "Error", message: "You must be at least 21 to create an account", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                if(error != nil){
                    let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
