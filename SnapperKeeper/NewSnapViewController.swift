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

class NewSnapViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	
	var username = ""
	var imagePicker: UIImagePickerController!
	
    @IBOutlet weak var snapNameField: UITextField!
	@IBOutlet weak var snapImageField: UIImageView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true
		imagePicker.delegate = self
		
		DataService.ds.REF_USERS.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
			let value = snapshot.value as? NSDictionary
			self.username = value?["username"] as! String })

    }
    
    //MARK: - IBActions
    @IBAction func saveSnapButtonPressed(_ sender: AnyObject) {
        let snapRef = FIRDatabase.database().reference().child("snaps").childByAutoId()
		
        if let snapName = snapNameField.text, snapName != "" {
			let snap = Snap(snapName: snapName, snapOwner: username,
			                snapComments: "none", imageURL: "none", uid: uid)
			snapRef.setValue(snap.toAnyObject())
			_ = self.navigationController?.popToRootViewController(animated: true)
			
        }
    }
   
	@IBAction func imageTapped(_ sender: AnyObject) {
		present(imagePicker, animated: true, completion: nil)
	}
	
	
	//MARK: - ImagePicker Delegate Functions
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			snapImageField.image = image
		} else {
			print("no image selected")
		}
		
		imagePicker.dismiss(animated: true, completion: nil)
		
	}
}
