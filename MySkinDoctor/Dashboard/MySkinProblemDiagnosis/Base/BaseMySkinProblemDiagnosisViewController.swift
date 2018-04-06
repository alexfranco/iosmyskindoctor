//
//  BaseMySkinProblemDiagnosisViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BaseMySkinProblemDiagnosisViewController: BindingViewController {
	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var doctorNameLabel: UILabel!
	@IBOutlet weak var qualificationsLabel: UILabel!
	@IBOutlet weak var profileHeaderView: UIView!
	@IBOutlet weak var profileView: UIView!
	
	private var viewModelCast: BaseMySkinProblemDiagnosisViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! BaseMySkinProblemDiagnosisViewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		profileImageView?.setRounded()
		profileImageView.setWhiteBorder()
		
		title = viewModelCast.navigationTitle
		doctorNameLabel.text = viewModelCast.doctorNameText
		qualificationsLabel.text = viewModelCast.qualificationsText
		
		if let profileImageUrl = URL(string: (self.viewModelCast.profileImageUrl)) {
			self.profileImageView.sd_setImage(with: profileImageUrl, placeholderImage: UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!, options: .highPriority) { (image, error, type, url) in
				self.profileImageView.contentMode = .scaleAspectFill
			}
		}
		
		applyTheme()
	}
	
	func applyTheme() {
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: viewModelCast.viewBackgroundColor, titleColor: AppStyle.diagnoseViewTextColor)
				
		view.backgroundColor = viewModelCast.viewBackgroundColor
		profileHeaderView.backgroundColor = viewModelCast.viewBackgroundColor
			
		doctorNameLabel.textColor = AppStyle.diagnoseTitleColor
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		self.performSegue(withIdentifier: Segues.goToBookingConsult, sender: nil)
	}
}

