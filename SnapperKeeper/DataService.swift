//
//  DataService.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/20/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

//global firebase reference
let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
	
	//singleton database reference
	static let ds = DataService()
	
	//Firebase references
	private var _REF_BASE = DB_BASE
	private var _REF_USERS = DB_BASE.child("users")
	private var _REF_SNAPS = DB_BASE.child("snaps")
	private var _REF_SNAP_IMAGE_STORAGE = STORAGE_BASE.child("snapImages")
	
	//public getters
	var REF_BASE: FIRDatabaseReference {
		return _REF_BASE
	}
	
	var REF_USERS: FIRDatabaseReference {
		return _REF_USERS
	}
	
	var REF_SNAPS: FIRDatabaseReference {
		return _REF_SNAPS
	}
	
	var REF_SNAP_IMAGE_STORAGE: FIRStorageReference {
		return _REF_SNAP_IMAGE_STORAGE
	}
	
	//database functions
	func createFirebaseDBUser(uid: String, userData: Dictionary<String, String> ) {
		REF_USERS.child(uid).updateChildValues(userData)
	}
	
	
	
	
}
