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
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

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
        
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
    }
    
    @IBAction func onPressContinue(_ sender: Any) {

        if(firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || phoneTextField.text == "" || passwordTextField.text == "" || passwordConfirmTextField.text == ""){
                let alertController = UIAlertController.init(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
        }
        else if(!isValidEmail(emailTextField.text ?? "")){
                let alertController = UIAlertController.init(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
        }
        else if(!isValidPhone(phoneTextField.text ?? "")){
                let alertController = UIAlertController.init(title: "Error", message: "Please enter a valid phone number (XXX-XXX-XXXX)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
        }
        else if(passwordTextField.text != passwordConfirmTextField.text){
            let alertController = UIAlertController.init(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if(passwordTextField.text!.count < 6){
            let alertController = UIAlertController.init(title: "Error", message: "Password must be at least 6 characters long", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            self.user.firstName = self.firstNameTextField.text
            self.user.lastName = self.lastNameTextField.text
            self.user.email = self.emailTextField.text
            self.user.phone = self.phoneTextField.text
            self.performSegue(withIdentifier: "SignUpToSignUp2", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUp2ViewController{
            let vc = segue.destination as? SignUp2ViewController
            vc?.email = self.emailTextField.text!
            vc?.password = self.passwordTextField.text!
            vc?.user = self.user
        }
    }
}
