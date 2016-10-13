//
//  NewSnapViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/10/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class NewSnapViewController: UIViewController {

    @IBOutlet weak var snapNameField: UITextField!
	@IBOutlet weak var snapImageField: UIImageView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func saveSnapButtonPressed(_ sender: AnyObject) {
        let snapRef = FIRDatabase.database().reference().child("snaps").childByAutoId()
		
        if let snapName = snapNameField.text, snapName != "" {
			print(FIRAuth.auth()?.currentUser?.displayName)
			let snap = Snap(snapName: snapName, snapOwner: (FIRAuth.auth()?.currentUser?.email)!, uid: (FIRAuth.auth()?.currentUser?.uid)!)
			snapRef.setValue(snap.toAnyObject())
			_ = self.navigationController?.popToRootViewController(animated: true)
			
        }
    }
   
}
