//
//  MainViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/8/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

//global variable UID
let uid = KeychainWrapper.standard.string(forKey: KEY_UID)!

class MainViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    var snaps = [Snap]()
	var indexPath = 0
	
    @IBOutlet weak var profileButtonLabel: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
		
		//Firebase observer
		DataService.ds.REF_SNAPS.queryOrdered(byChild: uid).queryEqual(toValue: "true").observe(.value, with: { snapshot in
            self.snaps = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    let newSnap = Snap(snapshot: snap)
                    self.snaps.append(newSnap)
                }
            }
            self.collectionView?.reloadData()
        })

        
    }
    
   
    
    //MARK: - collectionView functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return snaps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_SNAPS, for: indexPath) as? SnapCell {
			cell.configureCell(snap: snaps[indexPath.row])
			return cell
		} else {
			return SnapCell()
		}
		
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

	}
	
	
	//MARK: - Segue overrides
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == SEGUE_SHOW_SNAP_DETAILS {
			let vc = segue.destination as! SnapDetailViewController
			let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell)
			vc.snap = snaps[(indexPath?.row)!]
		}
		
	}
    
    
    
}
