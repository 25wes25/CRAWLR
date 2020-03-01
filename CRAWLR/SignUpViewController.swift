//
//  SignUpViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/12/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    var emailValidation = false
    
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
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "FIRST NAME*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "LAST NAME*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "PHONE*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passwordConfirmTextField.attributedPlaceholder = NSAttributedString(string: "CONFIRM PASSWORD*",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
         continueButton.isEnabled = false 
         firstNameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
         lastNameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
         emailTextField.addTarget(self, action: #selector(isValidEmail),
                                     for: .editingDidEnd)
         phoneTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
         passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
         passwordConfirmTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
    }
    
    @objc func isValidEmail(sender: UITextField){
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let email = emailTextField.text
        if(emailPred.evaluate(with: email)){
            emailValidation = true
        }
        else{
            emailValidation = false
        }
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {

//        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)

        guard
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let passwordConfirm = passwordConfirmTextField.text,
               password == passwordConfirm
            else{
                continueButton.alpha = 0.5
                self.continueButton.isEnabled = false
                return
            }
            // enable continueButton if all conditions are met
            if(emailValidation){
                continueButton.alpha = 1
                continueButton.isEnabled = true
            }
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
        
  
    @IBAction func onPressContinue(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUpToSignUp2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUp2ViewController{
            let vc = segue.destination as? SignUp2ViewController
            vc?.email = self.emailTextField.text!
            vc?.password = self.passwordTextField.text!
        }
    }
}
