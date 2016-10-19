//
//  NetworkingServices.swift
//  tasknerd
//
//  Created by Eric Torigian on 7/30/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


struct NetworkingServices {
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storeageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    var storeageBaseRef: FIRStorage! {
        return FIRStorage.storage()
    }
	
	var usersRef: FIRDatabaseReference {
		return FIRDatabase.database().reference(withPath: "online")
	}
    
    private func saveUserInfo(user: FIRUser, username: String, password: String) {
        //build User Dictionary
        let userInfo = ["email": user.email!, "username": username, "uid": user.uid, "photoURL": String(describing: user.photoURL!)]
        let userRef = databaseRef.child("users").child(user.uid)
        userRef.setValue(userInfo)
        signInUser(email: user.email!, password: password)
    }
    
    func signInUser(email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print("user \(user.displayName) has signed in")
                } else {
                    print("signIn error: \(error?._code)")
                }
            } else if error!._code == 17011 {
                print("signIn error:  not logged in")
            }
        })
        
    }
    
    private func setUserInfo(user: FIRUser, username: String, password: String, data: NSData!) {
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storeageRef.child(imagePath)
        
        //create metadata for image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error != nil {
                        print("setUserInfo error\(error?.localizedDescription)")
                    } else {
                        self.saveUserInfo(user: user, username: username, password: password)
                    }
                })
            } else {
                print(error!.localizedDescription)
            }
        }
    }

    func createUser(email: String, username: String, password: String, data: NSData!) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user: user!, username: username, password: password, data: data)
            } else {
                print("createUser error \(error!.localizedDescription)")
            }
            
        })
    }
    
    func resetPwd(email: String) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("an email with instructions on how to reset your password has been emailed to you")
            } else {
                print("reset password error:  \(error?.localizedDescription)")
            }
        })
    }
    
}
