//
//  SignUp2ViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/13/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController{
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
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
        // TO-DO
    }
}
