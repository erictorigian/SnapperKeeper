//
//  SnapCell.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/10/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase


class SnapCell: UICollectionViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	func configureCell(snap: Snap, img: UIImage?) {
		self.nameLabel.text = snap.snapName
		
		//check for passed image from queue or else get it from firebase
		if img != nil {
			self.imageView.image = img
		} else {
			let ref = FIRStorage.storage().reference(forURL: snap.imageURL)
			ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
				if error != nil {
					print("SnapCell unable to download image: \(error?.localizedDescription)")
				} else {
					print("image downloaded")
					if let imgData = data {
						if let img = UIImage(data: imgData) {
							self.imageView.image = img
							MainViewController.imageCache.setObject(img, forKey: snap.imageURL as NSString)
						}
					}
				}
			})
		}
		
	}
	
}
