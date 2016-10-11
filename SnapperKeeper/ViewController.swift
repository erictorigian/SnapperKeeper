//
//  ViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/7/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI


class ViewController: UIViewController, FIRAuthUIDelegate {
//    let googleAuthUI = FIRGoogleAuthUI(ClientID: kGoogleClientID)
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	
    //MARK: - firebaseUI delegate methods
    func authUI(_ authUI: FIRAuthUI, didSignInWith user: FIRUser?, error: Error?) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        let authUI = FIRAuthUI.default()
        
        let options = FIRApp.defaultApp()?.options
        let clientId = options?.clientID
        
        let providers: [FIRAuthProviderUI] = [FIRGoogleAuthUI()]
        
        authUI?.delegate = self
        
        authUI?.providers = providers
        
        let authViewController = authUI?.authViewController();
        self.present(authViewController!, animated: true, completion: nil)
        
        
    }

}

