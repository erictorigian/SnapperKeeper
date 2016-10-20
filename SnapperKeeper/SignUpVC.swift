//
//  SignUpVC.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/15/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	let networkingService = NetworkingServices()
    let pickerController = UIImagePickerController()
    
    @IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var passwordConfirmField: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self
        // Do any additional setup after loading the view.
    }

	@IBAction func userImageTap(_ sender: AnyObject) {

        pickerController.allowsEditing = true
		
		let alertController = UIAlertController(title: "Choose a Picture", message: "Choose your source for your picture", preferredStyle: .actionSheet)
		
		let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .camera
            self.pickerController.cameraCaptureMode = .photo
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .photoLibrary
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let savedPhotosAlbumAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .savedPhotosAlbum
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
		
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }

		alertController.addAction(photoLibraryAction)
		alertController.addAction(savedPhotosAlbumAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		self.dismiss(animated: true, completion: nil)
		self.userImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
	}
	
	
	@IBAction func signUpBtnPressed(_ sender: AnyObject) {
        let data = UIImageJPEGRepresentation(userImageView.image!, 0.8)
        networkingService.createUser(emailField.text!, username: usernameField.text!, password: passwordField.text!, data: data as Data!)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(vc, animated: true, completion: nil)

	}
}
