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
	
	var viewModelCast: MedicalHistoryViewModel!
			
	@IBOutlet weak var hasHealthProblemsLabel: GrayLabel!
	@IBOutlet weak var hasHealthProblemsSwitch: UISwitch!
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { self.viewModelCast.healthProblemDescription = $0 }
		}
	}
	@IBOutlet weak var hasMedicationLabel: GrayLabel!
	@IBOutlet weak var hasMedicationSwitch: UISwitch!
	@IBOutlet weak var hasPastHistoryProblemsLabel: GrayLabel!
	@IBOutlet weak var hasPastHistoryProblemsSwitch: UISwitch!
	@IBOutlet weak var saveMedicalHistoryView: UIView!
	@IBOutlet weak var saveMedicalHistoryLabel: UILabel!
	@IBOutlet weak var saveMedicalHistorySwitch: UISwitch!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Medical History"
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		descriptionTextView.placeholder = "Enter here your health problems"
	
		saveMedicalHistoryView.backgroundColor = AppStyle.medicalHistorySaveViewBackgroundColor
		saveMedicalHistoryLabel.textColor = AppStyle.medicalHistorySaveLabelTextColor
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		initViewModel(viewModel: MedicalHistoryViewModel())
	}
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! MedicalHistoryViewModel)
		
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				//self.performSegue(withIdentifier: Segues.unwindToAddSkinProblemsWithSegue, sender: nil)
			}
		}
	}
	
	@IBAction func onHasHealthProblemsSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasHealthProblems = hasHealthProblemsSwitch.isOn
	}
	
	@IBAction func onHasMedicationSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasMedication = hasMedicationSwitch.isOn
	}
	
	@IBAction func onHasPastHistoryProblemsSwitchValueChanged(_ sender: Any) {
		viewModelCast.hasPastHistoryProblems = hasMedicationSwitch.isOn
	}
	
	@IBAction func onSaveMedicalHistorySwitchValueChanged(_ sender: Any) {
		viewModelCast.saveMedicalHistory = saveMedicalHistorySwitch.isOn
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
}
