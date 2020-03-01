//
//  SignUp2ViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/13/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Firebase

class SignUp2ViewController: UIViewController{
  
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    var email: String = ""
    var password: String = ""
    var validateTextFields = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAddTargetIsNotEmptyTextFields()

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
       
    func setupAddTargetIsNotEmptyTextFields() {
            createAccountButton.isEnabled = false
            usernameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                        for: .editingChanged)
            ageTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                   for: .editingChanged)
            maleButton.addTarget(self, action: #selector(genderSelectionIsNotEmpty), for: .allEvents)
            femaleButton.addTarget(self, action: #selector(genderSelectionIsNotEmpty), for: .allEvents)
            otherButton.addTarget(self, action: #selector(genderSelectionIsNotEmpty), for: .allEvents)
    }
    
    @objc func genderSelectionIsNotEmpty(sender: UIButton){
        if((maleButton.isSelected || femaleButton.isSelected || otherButton.isSelected) && validateTextFields){
            createAccountButton.alpha = 1
            createAccountButton.isEnabled = true
        }
        else{
            createAccountButton.alpha = 0.5
            createAccountButton.isEnabled = false
        }
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let username = usernameTextField.text, !username.isEmpty,
            let age = ageTextField.text, !age.isEmpty
            else{
                createAccountButton.alpha = 0.5
                self.createAccountButton.isEnabled = false
                return
            }
            // enable createAccountButton if all conditions are met
            validateTextFields = true
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
            sender.isSelected = false
            femaleButton.isSelected = false
            otherButton.isSelected = false
        } else{
            sender.isSelected = true
            femaleButton.isSelected = false
            otherButton.isSelected = false
        }
    }
    
    @IBAction func onPressFemaleButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            maleButton.isSelected = false
            otherButton.isSelected = false
        } else{
            sender.isSelected = true
            maleButton.isSelected = false
            otherButton.isSelected = false
        }
    }
    
    @IBAction func onPressOtherButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            femaleButton.isSelected = false
            maleButton.isSelected = false
        } else{
            sender.isSelected = true
            femaleButton.isSelected = false
            maleButton.isSelected = false
        }
    }
    
    @IBAction func OnPressCreateAccount(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
          print(authResult?.user)
          print(error?.localizedDescription)
        }
    }
}
