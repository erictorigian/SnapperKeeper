//
//  NewSnapViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/10/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class NewSnapViewController: UIViewController {
	var username = ""

    @IBOutlet weak var snapNameField: UITextField!
	@IBOutlet weak var snapImageField: UIImageView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		DataService.ds.REF_USERS.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
			let value = snapshot.value as? NSDictionary
			self.username = value?["username"] as! String })

    }
    
    
    @IBAction func saveSnapButtonPressed(_ sender: AnyObject) {
        let snapRef = FIRDatabase.database().reference().child("snaps").childByAutoId()
		
        if let snapName = snapNameField.text, snapName != "" {
			let snap = Snap(snapName: snapName, snapOwner: username, imageURL: "none", uid: uid)
			snapRef.setValue(snap.toAnyObject())
			_ = self.navigationController?.popToRootViewController(animated: true)
			
        }
    }
   
}
