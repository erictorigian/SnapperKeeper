//
//  NewSnapViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/10/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class NewSnapViewController: UIViewController {

    @IBOutlet weak var snapNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveSnapButtonPressed(_ sender: AnyObject) {
        
        if let snapName = snapNameField.text, snapName != "" {
            print("New snap: \(snapName)")
        }
    }
   
}
