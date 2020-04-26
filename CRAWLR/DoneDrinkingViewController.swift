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
        //fetchContacts()
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys =
            [CNContactGivenNameKey
                , CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
        
    }
    


        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            // You can fetch selected name and number in the following way

            // user phone number
            let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
            let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value


            // user phone number string
            let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue

            print(primaryPhoneNumberStr)

        }

        
    }


