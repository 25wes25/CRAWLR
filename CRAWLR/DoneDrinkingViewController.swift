//
//  DoneDrinkingViewController.swift
//  CRAWLR
//
//  Created by Mayra Sanchez on 4/21/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

import Foundation

class DoneDrinkingController: UIViewController, CNContactPickerDelegate{

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
}
    
    @IBAction func OnPressContacts(_ sender: Any) {
        fetchContacts()
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys =
            [CNContactGivenNameKey
                , CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
        
    }
    
    private func fetchContacts() {
        print("Attempting to fetch contatcs...") //testing
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access", err)
                return
            }
            if granted {
                print("Access granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,
                CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerifYouWantToStopEnumerating) in
                        //print(contact.givenName, "", contact.familyName,"|", contact.phoneNumbers.first?.value.stringValue ?? "", "\n")//prints contacts
                    })
                } catch let err{
                    print("Failed to enumerate Contacts: ", err)
                }
                
                
            } else {
               print("Access denied")
            }
            
        }


        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // You can fetch selected name and number in the following way

            // user name
            let userName:String = contact.givenName

            // user phone number
            let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
            let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value


            // user phone number string
            let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue

            print(primaryPhoneNumberStr)

        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

        }
        
    }

    
}
