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
    
    var user: User?
    
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
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to defaults
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.isTranslucent = true
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
        self.user?.gender = "male"
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
        self.user?.gender = "female"
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
        self.user?.gender = "other"
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
        var age = 0;
        if let ageText = self.ageTextField.text {
            if let ageInt = Int(ageText) {
                age = ageInt
            }
        }
        if(usernameTextField.text == "" || ageTextField.text == "" || validateButtons == false){
            let alertController = UIAlertController.init(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else if(age < 21){
            let alertController = UIAlertController.init(title: "Error", message: "You must be at least 21 to create an account", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            self.user?.age = Double(age)
            self.user?.username = usernameTextField.text
            Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                if(error != nil){
                    let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                        if(error != nil){
                            let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                            let onDidCreateUser: (User?) -> Void = { user in
                                self.user = user
                                self.performSegue(withIdentifier: "SignUpSegueToTabBarController", sender: self)
                            }
                            if let user = self.user {
                                ApiHelper.instance.createUser(user: user, callback: onDidCreateUser)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UITabBarController {
            let tabBarController = segue.destination as? UITabBarController
            if let viewControllers = tabBarController?.viewControllers {
                let dashboardNavigationController = viewControllers[0] as? UINavigationController
                let dashboardViewController = dashboardNavigationController?.viewControllers[0] as? DashboardViewController
                dashboardViewController?.user = self.user
                let searchNavigationController = viewControllers[1] as? UINavigationController
                let searchViewController = searchNavigationController?.viewControllers[0] as? SearchViewController
                searchViewController?.user = self.user
                let profileNavigationController = viewControllers[2] as? UINavigationController
                let profileViewController = profileNavigationController?.viewControllers[0] as? ProfileViewController
                profileViewController?.user = self.user
            }
        }
    }
}
