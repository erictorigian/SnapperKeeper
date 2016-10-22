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
	@IBOutlet weak var snapCommentsField: UITextView!
	@IBOutlet weak var snapTagsField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = true
		imagePicker.delegate = self
		
		DataService.ds.REF_USERS.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
			let value = snapshot.value as? NSDictionary
			self.username = value?["username"] as! String })
		
	}
	
	func showErrorAlert(_ title: String, msg: String) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	
	//MARK: - IBActions
	@IBAction func saveSnapButtonPressed(_ sender: AnyObject) {
		guard let snapName = snapNameField.text , snapName != "" else {
			showErrorAlert("Save new Snap Error", msg: "Every snap must have a name")
			return
		}
		
		guard let image = snapImageField.image else {
			showErrorAlert("Save snap error", msg: "You must select an image")
			return
		}
		
		guard let comments = snapCommentsField.text, comments != "" else {
			showErrorAlert("Save snap erorr", msg: "You must enter comments for the snap")
			return
		}
		
		if let imgData = UIImageJPEGRepresentation(image, 0.2) {
			let imageUID = NSUUID().uuidString
			let metaData = FIRStorageMetadata()
			metaData.contentType = "image/jpg"
			
			DataService.ds.REF_SNAP_IMAGE_STORAGE.child(imageUID).put(imgData, metadata: metaData) { (metadata, error) in
				if let error = error {
					self.showErrorAlert("Error uploading image", msg: error.localizedDescription)
				} else {
					let downloadURL = metadata?.downloadURL()?.absoluteString
					
					let snapRef = DataService.ds.REF_SNAPS.childByAutoId()
					
					let snap = Snap(snapName: snapName, snapOwner: self.username,
					                snapComments: self.snapCommentsField.text, imageURL: downloadURL!, uid: uid)
					
					snapRef.setValue(snap.toAnyObject())
					
					_ = self.navigationController?.popToRootViewController(animated: true)
					
				}
				
			}
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
