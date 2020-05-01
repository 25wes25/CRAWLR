//
//  EditProfileViewController.swift
//  CRAWLR
//
//  Created by Lauren Dyson on 4/25/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Photos


class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User?
    var selectedUserID: String?
    var profilePic : UIImage! = UIImage(named: "tempContact")
    let picker = UIImagePickerController()

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var EditProfilePicImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = user?.username
        weightTextField.text = String(Int((user?.weight ?? 0)))
        ageTextField.text = String(Int(user?.age ?? 21))
        heightTextField.text = (user?.height ?? "5'5")
        EditProfilePicImageView.image = profilePic
        EditProfilePicImageView.contentMode = .scaleAspectFill
        picker.delegate = self
        
        
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
    
    
    @IBAction func onChangeProfilePicPress(_ sender: Any) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        PHPhotoLibrary.requestAuthorization({_ in
            if photoAuthorizationStatus == .authorized{
                self.changePhoto()
            }
            else if photoAuthorizationStatus == .restricted {
                let alertController = UIAlertController.init(title: "Error", message: "User does not have access to photo library.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else if photoAuthorizationStatus == .denied {
                let alertController = UIAlertController.init(title: "Error", message: "User has denied the permission.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        })

    }
    
    func changePhoto(){
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonPress(_ sender: Any) {
       if let username = usernameTextField.text {
            user?.username = username
       }
       
       if let weight = weightTextField.text {
            if let weightDouble = Double(weight) {
                if weightDouble >= 0 {
                   user?.weight = weightDouble
                } else {
                    weightTextField.text = String(Int(user?.weight ?? 0))
                    let alertController = UIAlertController.init(title: "Error", message: "You cannot have a negative weight", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
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
       self.performSegue(withIdentifier: "EditProfiletoProfileUnwindSegue", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            EditProfilePicImageView.contentMode = .scaleAspectFill
            EditProfilePicImageView.image = pickedImage
            profilePic = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



