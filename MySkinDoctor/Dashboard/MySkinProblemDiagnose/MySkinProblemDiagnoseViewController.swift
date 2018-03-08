//
//  MySkinProblemDiagnoseViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 08/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnoseViewController: BindingViewController {
	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var doctorNameLabel: UILabel!
	@IBOutlet weak var qualificationsLabel: UILabel!
	@IBOutlet weak var profileHeaderView: UIView!
	@IBOutlet weak var profileView: UIView!
	
	var viewModelCast: MySkinProblemDiagnoseViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MySkinProblemDiagnoseViewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		applyTheme()
		
		profileImageView.image = viewModelCast.profileImage
		profileImageView?.setRounded()
		profileImageView.setWhiteBorder()
		
		doctorNameLabel.text = viewModelCast.doctorNameText
		qualificationsLabel.text = viewModelCast.qualificationsText
	}
	
	func applyTheme() {
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: viewModelCast.viewBackgroundColor, titleColor: AppStyle.diagnoseViewTextColor)
		
		nextButton.backgroundColor = AppStyle.diagnoseNextButtonColor
		
		view.backgroundColor = viewModelCast.viewBackgroundColor
		profileHeaderView.backgroundColor = viewModelCast.viewBackgroundColor
		
		doctorNameLabel.textColor = AppStyle.diagnoseTitleColor
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		//performSegue(withIdentifier: Segues.unwindToMyConsults, sender: nil)
	}
}

