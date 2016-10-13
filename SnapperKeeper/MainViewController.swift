//
//  MainViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/8/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    var snaps = [Snap]()
    let snapsRef = FIRDatabase.database().reference(withPath: "/snaps")
	let user_id = FIRAuth.auth()?.currentUser?.uid
	
    
    @IBOutlet weak var profileButtonLabel: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
		
        snapsRef.queryOrdered(byChild: user_id!).queryEqual(toValue: "true").observe(.value, with: { snapshot in
            self.snaps = []
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for fbSnap in snapshots {
                    let tempSnap = Snap(snapshot: fbSnap)
                    self.snaps.append(tempSnap)
                    print(tempSnap.snapName)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_SNAPS, for: indexPath) as! SnapCell
        
        // Configure the cell
        cell.nameLabel.text = snaps[indexPath.row].snapName
        cell.imageView.backgroundColor = UIColor.blue
        return cell
    }
    
    
    
    
}
