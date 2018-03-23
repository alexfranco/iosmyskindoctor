//
//  MedicalHistoryViewControler.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 02/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MedicalHistoryViewControler: FormViewController {
	
	let defaultTextViewHeight = CGFloat(90)
	
	var viewModelCast: MedicalHistoryViewModel!
			
	@IBOutlet weak var hasHealthProblemsLabel: GrayLabel!
	@IBOutlet weak var hasHealthProblemsSwitch: UISwitch!
	@IBOutlet weak var healthProblemsTextView: FormTextView! {
		didSet {
			healthProblemsTextView.bind { self.viewModelCast.healthProblems = $0 }
		}
	}
	@IBOutlet weak var healthProblemsConstraint: NSLayoutConstraint!
	@IBOutlet weak var hasMedicationLabel: GrayLabel!
	@IBOutlet weak var hasMedicationSwitch: UISwitch!
	@IBOutlet weak var medicationTextView: FormTextView! {
		didSet {
			medicationTextView.bind { self.viewModelCast.medication = $0 }
		}
	}
	@IBOutlet weak var medicalConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var hasPastHistoryProblemsLabel: GrayLabel!
	@IBOutlet weak var hasPastHistoryProblemsSwitch: UISwitch!
	@IBOutlet weak var pastHistoryProblemsTextView: FormTextView! {
		didSet {
			pastHistoryProblemsTextView.bind { self.viewModelCast.pastHistoryProblems = $0 }
		}
	}
	@IBOutlet weak var pastHistoryProblemsConstraint: NSLayoutConstraint!
	@IBOutlet weak var saveMedicalHistoryView: UIView!
	@IBOutlet weak var saveMedicalHistoryLabel: UILabel!
	@IBOutlet weak var saveMedicalHistorySwitch: UISwitch!
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
		hasHealthProblemsSwitch.isOn = viewModelCast.hasHealthProblems
		hasMedicationSwitch.isOn = viewModelCast.hasMedication
		hasPastHistoryProblemsSwitch.isOn = viewModelCast.hasPastHistoryProblems
		saveMedicalHistorySwitch.isOn = viewModelCast.saveMedicalHistory
		
		applyLocalization()
		applyTheme()
	}
		
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! MedicalHistoryViewModel)
		
		viewModelCast.healthProblemsViewConstraintUpdate = { [weak self] (show) in
			DispatchQueue.main.async {
				self?.healthProblemsTextView.isHidden = !show
				self?.healthProblemsConstraint.constant = show ? (self?.defaultTextViewHeight)! : 0
			}
		}
		
		viewModelCast.medicationViewConstraintUpdate = { [weak self] (show) in
			DispatchQueue.main.async {
				self?.medicationTextView.isHidden = !show
				self?.medicalConstraint.constant = show ? (self?.defaultTextViewHeight)! : 0
			}
		}
		
		viewModelCast.pastHistoryProblemsViewConstraintUpdate = { [weak self] (show) in
			DispatchQueue.main.async {
				self?.pastHistoryProblemsTextView.isHidden = !show
				self?.pastHistoryProblemsConstraint.constant = show ? (self?.defaultTextViewHeight)! : 0
			}
		}
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToSkinProblemThankYouViewControllerFromMedicalHistory, sender: nil)
			}
		}
	}
	
	@IBAction func onHasHealthProblemsSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasHealthProblems = hasHealthProblemsSwitch.isOn
	}
	
	@IBAction func onHasMedicationSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasMedication = hasMedicationSwitch.isOn
	}
	
	@IBAction func onSaveMedicalHistorySwitchValueChanged(_ sender: Any) {
		viewModelCast.saveMedicalHistory = saveMedicalHistorySwitch.isOn
	}
	
	@IBAction func onHasPastHistoryProblemsSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasPastHistoryProblems = hasPastHistoryProblemsSwitch.isOn
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	func applyLocalization() {
		title = NSLocalizedString("medical_history_main_vc_title", comment: "")
		healthProblemsTextView.placeholder = NSLocalizedString("medical_history_enter_health_problems", comment: "")
		medicationTextView.placeholder = NSLocalizedString("medical_history_enter_medication", comment: "")
		pastHistoryProblemsTextView.placeholder = NSLocalizedString("medical_history_enter_past_history_problems", comment: "")
		
		saveMedicalHistoryLabel.text = NSLocalizedString("medical_history_save_my_medical_history", comment: "")
		nextButton.setTitle(NSLocalizedString("medical_history_finish_and_submit", comment: ""), for: .normal)
	}
	
	func applyTheme() {
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		saveMedicalHistoryView.backgroundColor = AppStyle.medicalHistorySaveViewBackgroundColor
		saveMedicalHistoryLabel.textColor = AppStyle.medicalHistorySaveLabelTextColor
		saveMedicalHistoryLabel.font = AppFonts.defaultBoldFont
	}
}
