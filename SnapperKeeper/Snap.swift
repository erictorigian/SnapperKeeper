//
//  Snap.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/12/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct Snap {
    
    //MARK: -  Class Variables
    var snapName: String!
    var snapOwner: String!
    var key: String!
    var ref: FIRDatabaseReference?
    var uid: String
    
    
    
    //MARK: - Initalizers
    init (snapName: String, snapOwner: String, uid: String) {
        self.snapName = snapName
        self.snapOwner = snapOwner
        self.key = ""
        self.ref = FIRDatabase.database().reference()
        self.uid = uid
        
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.snapName = (snapshot.value as? NSDictionary)?["snapName"] as! String
        self.snapOwner = (snapshot.value as? NSDictionary)?["snapOwner"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.uid = (FIRAuth.auth()?.currentUser?.uid)!
        
    }
    
    
    func toAnyObject() -> [String: AnyObject] {
        var snapDict: [String: String]
        let uid_string = uid
        snapDict = ["snapName": snapName, "snapOwner": snapOwner,
                    uid_string: "true"]
        
        return snapDict as [String : AnyObject]
    }
    
    
}
