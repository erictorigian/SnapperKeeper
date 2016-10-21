//
//  SnapDetailViewController.swift
//  SnapperKeeper
//
//  Created by Eric Torigian on 10/21/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class SnapDetailViewController: UIViewController {

	var snap: Snap!
	
	@IBOutlet weak var snapNameLabel: UINavigationItem!
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		snapNameLabel.title = snap.snapName
    }



}
