//
//  Snap.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/12/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

class Snap {
    
    //MARK: -  private Class Variables
    private var _snapName: String!
    private var _snapOwner: String!
	private var _imageURL: String!
    private var _snapComments: String!
    private var _key: String!
    private var _ref: FIRDatabaseReference?
	private var _snapUID: String!
	
    //MARK: - public getters
	var snapName: String {
		return _snapName
	}
	
	var snapOwner: String {
		return _snapOwner
	}
	
	var imageURL: String {
		return _imageURL
	}
    
    var snapComments: String {
        return _snapComments
    }
	
	var key: String {
		return _key
	}
	
	var ref: FIRDatabaseReference {
		return _ref!
	}
	
	var snapUID: String {
		return _snapUID
	}
    
    //MARK: - Initalizers
    init (snapName: String, snapOwner: String, snapComments: String, imageURL: String, uid: String) {
        self._snapName = snapName
        self._snapOwner = snapOwner
        self._snapComments = snapComments
		self._imageURL = imageURL
        self._key = ""
        self._ref = FIRDatabase.database().reference()
		self._snapUID = uid
		
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        self._snapName = (snapshot.value as? NSDictionary)?["snapName"] as! String
        self._snapOwner = (snapshot.value as? NSDictionary)?["snapOwner"] as! String
        self._snapComments = (snapshot.value as? NSDictionary)?["snapComments"] as! String
		self._imageURL = (snapshot.value as? NSDictionary)?["imageURL"] as! String
        self._key = snapshot.key
        self._ref = snapshot.ref
		self._snapUID = uid
		
    }
    
    //MARK: - convert functions
    func toAnyObject() -> [String: AnyObject] {
        var snapDict: [String: String]
        snapDict = ["snapName": _snapName, "snapOwner": _snapOwner,
                    "snapComments": _snapComments, "imageURL": _imageURL, uid: "true"]
        
        return snapDict as [String : AnyObject]
    }
    
    
}
