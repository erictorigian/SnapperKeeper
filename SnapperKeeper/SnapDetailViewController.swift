//
//  SnapDetailViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/21/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

class SnapDetailViewController: UIViewController {

	var snap: Snap!
	
	@IBOutlet weak var snapNameLabel: UINavigationItem!
    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var snapCommentsLabel: UITextView!
    @IBOutlet weak var snapTagsLabel: UITextField!
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		snapNameLabel.title = snap.snapName
        snapCommentsLabel.text = snap.snapComments
        
        if let img = MainViewController.imageCache.object(forKey: snap.imageURL as NSString) {
            snapImageView.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: snap.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                if error != nil {
                    print("snapDetails unable to download image: \(error?.localizedDescription)")
                } else {
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.snapImageView.image = img
                            MainViewController.imageCache.setObject(img, forKey: self.snap.imageURL as NSString)
                        }
                    }
                }
            })

            
        }

        
    }



}
