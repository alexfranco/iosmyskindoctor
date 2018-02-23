//
//  ProfileViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: PhotoViewController {
	
	@IBOutlet weak var profileTopView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Profile"
		
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.barTintColor = AppStyle.profileTopViewBackgroundColor
		navigationController?.navigationBar.tintColor = AppStyle.profileNavigationBarTitleColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : AppStyle.profileNavigationBarTitleColor]

		profileTopView.backgroundColor = AppStyle.profileTopViewBackgroundColor

	}
}
