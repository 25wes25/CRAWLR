//
//  EstimatedBACViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/19/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit

class EstimatedBACViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 18)!
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs
        
    }
    
  
}
