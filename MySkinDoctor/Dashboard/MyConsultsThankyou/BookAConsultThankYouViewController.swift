//
//  BookAConsultThankYouViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BookAConsultThankYouViewController: BindingViewController {
	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var thankYouLabel: UILabel!
	@IBOutlet weak var consultationBookedLabel: UILabel!
	@IBOutlet weak var doctorNameLabel: UILabel!
	@IBOutlet weak var qualificationsLabel: UILabel!
	@IBOutlet weak var appointmentDateLabel: UILabel!
	@IBOutlet weak var appointmentTitleLabel: GrayLabel!
	@IBOutlet weak var appointmentView: UIView!
	@IBOutlet weak var profileHeaderView: UIView!
	@IBOutlet weak var profileView: UIView!
	
	var viewModelCast: BookAConsultThankYouViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! BookAConsultThankYouViewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		applyTheme()
		
		profileImageView.image = viewModelCast.profileImage
		profileImageView?.setRounded()
		profileImageView.setWhiteBorder()
		
		doctorNameLabel.text = viewModelCast.doctorNameText
		qualificationsLabel.text = viewModelCast.qualificationsText
		appointmentDateLabel.text = viewModelCast.appointmentDateText
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	func applyTheme() {
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		view.backgroundColor = AppStyle.consultThankYouViewBackgroundColor
		profileHeaderView.backgroundColor = AppStyle.consultThankYouViewBackgroundColor
		profileView.backgroundColor = AppStyle.consultThankYouProfileViewBackgroundColor
		appointmentView.backgroundColor = AppStyle.consultThankYouAppointmentViewBackgroundColor
		
		thankYouLabel.textColor = AppStyle.consultThankYouViewTextColor
		consultationBookedLabel.textColor = AppStyle.consultThankYouViewTextColor
		
		doctorNameLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
		appointmentDateLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
		
		thankYouLabel.font = AppFonts.bigFont
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
