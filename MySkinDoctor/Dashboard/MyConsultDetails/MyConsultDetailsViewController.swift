//
//  MyConsultDetailsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 14/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MyConsultDetailsViewController: BindingViewController {
	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var consultationBookedLabel: UILabel!
	@IBOutlet weak var doctorNameLabel: UILabel!
	@IBOutlet weak var qualificationsLabel: UILabel!
	@IBOutlet weak var appointmentDateLabel: UILabel!
	@IBOutlet weak var appointmentTitleLabel: GrayLabel!
	@IBOutlet weak var appointmentView: UIView!
	@IBOutlet weak var profileHeaderView: UIView!
	@IBOutlet weak var profileView: UIView!
	@IBOutlet weak var closeButton: UIBarButtonItem!
	@IBOutlet weak var cancelConsultation: UIBarButtonItem!
	
	var viewModelCast: MyConsultDetailsViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MyConsultDetailsViewModel
		
		viewModelCast.onFetchFinished = { [weak self] () in
			DispatchQueue.main.async {
				self?.dismiss(animated: true, completion: nil)
			}
		}
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToVideoConsultation, sender: nil)
			}
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		applyTheme()
		
		profileImageView?.setRounded()
		profileImageView.setWhiteBorder()
		
		doctorNameLabel.text = viewModelCast.doctorNameText
		qualificationsLabel.text = viewModelCast.qualificationsText
		appointmentDateLabel.text = viewModelCast.appointmentDateText
		
		cancelConsultation.isEnabled = viewModelCast.isBeforeConsultation()
		nextButton.isEnabled = viewModelCast.isConsultationTime()
		
		if let profileImageUrl = URL(string: (self.viewModelCast.profileImageUrl)) {
			self.profileImageView.sd_setImage(with: profileImageUrl, placeholderImage: UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!, options: .highPriority) { (image, error, type, url) in
				self.profileImageView.contentMode = .scaleAspectFill
			}
		}
	}
	
	func applyTheme() {
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		view.backgroundColor = AppStyle.consultThankYouViewBackgroundColor
		profileHeaderView.backgroundColor = AppStyle.consultThankYouViewBackgroundColor
		profileView.backgroundColor = AppStyle.consultThankYouProfileViewBackgroundColor
		appointmentView.backgroundColor = AppStyle.consultThankYouAppointmentViewBackgroundColor
		
		consultationBookedLabel.textColor = AppStyle.consultThankYouViewTextColor
		consultationBookedLabel.font = AppFonts.veryBigFont
		
		doctorNameLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
		appointmentDateLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.consultThankYouViewBackgroundColor, titleColor: AppStyle.consultThankYouViewTextColor)
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.startConsultation()
	}
	
	@IBAction func cancelConsultationButton(_ sender: Any) {
		let title: String = NSLocalizedString("booking_cancel_confirm_title", comment: "Cancel appointment")
		let message: String = String(format: NSLocalizedString("booking_cancel_confirm_message", comment: "Confirm cancellation"), arguments: [])
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
		
		let cancelAction = UIAlertAction(title: NSLocalizedString("no", comment: "No button"), style: .default) { (action) in
			// Do nothing
		}
		alertController.addAction(cancelAction)
		
		let OKAction = UIAlertAction(title: NSLocalizedString("yes", comment: "Yes button"), style: .default) { (action) in
			// Cancel appointment
			self.viewModelCast.cancelConsultation()
		}
		alertController.addAction(OKAction)
		
		self.present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func onCloseButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToVideoConsultation {
			if let dest = segue.destination as? MyConsultVideoChatViewController {
				dest.initViewModel(viewModel: MyConsultVideoChatViewModel(model: viewModelCast.model))
			}
		}
	}
}
