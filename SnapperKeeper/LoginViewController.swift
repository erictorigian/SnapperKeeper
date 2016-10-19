//
//  LoginViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/7/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (FIRAuth.auth()?.currentUser) != nil {
            performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }

    }
    
    
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        if let email = usernameTextField.text , email != "", let password = passwordTextField.text , password != "" {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    self.showErrorAlert(title: "Login Error", msg: error.localizedDescription)
                } else {
                    if user != nil {
                        self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                        print("user: \(user) logged in")
                    }
                }
                
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
            })
            
        } else {
            showErrorAlert(title: "Login Error", msg: "You must include both an email and password to login")
        }
    }
	
	@IBAction func facebookLoginButtonPressed(_ sender: AnyObject) {
		//authorize facebook
		let facebookLogin = FBSDKLoginManager()
		facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
			if error != nil {
				self.showErrorAlert(title: "Facebook Authentication Error", msg: (error?.localizedDescription)!)
			} else if result?.isCancelled == true {
				self.showErrorAlert(title: "Facebook Login Error", msg: "User cancelled authorization request")
			} else {
				let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
				self.firebaseAuth(credential)
				
			}
		}
	}
    
    @IBAction func signupButtonPressed(_ sender: AnyObject) {
        if let email = usernameTextField.text, email != "", let password = passwordTextField.text, password != "" {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {( user, error) in
                if let error = error {
                    self.showErrorAlert(title: "User Creation Error", msg: error.localizedDescription)
                } else {
                    print("user created")
                }
                })
        }
    }
    
    @IBAction func lostPasswordButtonPressed(_ sender: AnyObject) {
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
	
	func firebaseAuth(_ credential: FIRAuthCredential) {
		FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
			if error != nil {
				self.showErrorAlert(title: "Firebase authentication error", msg: (error?.localizedDescription)!)
			} else {
				self.showErrorAlert(title: "Firebase Authentication", msg: "Successfully authenticated")
			}
			
		})
	}
    
    
}
