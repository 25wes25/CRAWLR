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
        
    @IBAction func onPressForgotPassword(_ sender: Any) {
        
    }
    
    @IBAction func onPressSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginSegueToSignUp", sender: self)
    }
    
    @IBAction func onPressLogin(_ sender: Any) {
        
    }
}
