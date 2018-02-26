//
//  ProfileViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: FormViewController {
	
	@IBOutlet weak var profileTopView: UIView!
	@IBOutlet weak var nameLabel: TitleLabel!
	@IBOutlet weak var emailLabel: GrayLabel!
	@IBOutlet weak var userPhotoImageView: UIImageView!
	
	@IBOutlet weak var personalDetailsSectionLabel: BoldLabel!
	@IBOutlet weak var dobTextField: ProfileTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "My Profile"
		
		profileTopView.backgroundColor = AppStyle.profileTopViewBackgroundColor
		userPhotoImageView?.setRounded()
		userPhotoImageView.setWhiteBorder()
		
		let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
		imageTapGesture.delegate = self
		userPhotoImageView.addGestureRecognizer(imageTapGesture)
		imageTapGesture.numberOfTapsRequired = 1
		userPhotoImageView.isUserInteractionEnabled = true
		
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.barTintColor = AppStyle.profileTopViewBackgroundColor
		navigationController?.navigationBar.tintColor = AppStyle.profileNavigationBarTitleColor
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : AppStyle.profileNavigationBarTitleColor]
		
		initViewModel(viewModel: ProfileViewModel())
	}
}

extension ProfileViewController: UIGestureRecognizerDelegate {
	
	@objc func tapUserPhoto(_ sender: UITapGestureRecognizer) {
		let photoUtils = PhotoUtils(inViewController: self)
		photoUtils.showChoosePhoto { (success, image) in
			self.userPhotoImageView.contentMode = .scaleAspectFill
			self.userPhotoImageView.image = image
		}
	}
}
