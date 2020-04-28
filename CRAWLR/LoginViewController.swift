//
//  LoginViewController.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 2/11/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var email: String = ""
    var password: String = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification
        , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification
        , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
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
        if let emailText = usernameTextField.text {
            self.email = emailText.lowercased()
        }
        
        if let passwordText = passwordTextField.text {
            self.password = passwordText
        }
        
        
        if(self.email == "" || self.password == ""){
            let alertController = UIAlertController.init(title: "Error", message: "Please enter an email and password", preferredStyle: .alert)
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
                else{
                    let didGetUser: (User?) -> Void = { user in
                       self.user = user
                       self.performSegue(withIdentifier: "LoginSegueToTabBarController", sender: self)
                    }
                    ApiHelper.instance.getUser(email: self.email, callback: didGetUser)
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
