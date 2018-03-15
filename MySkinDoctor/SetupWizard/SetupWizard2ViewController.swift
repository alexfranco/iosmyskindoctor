//
//  SetupWizard2ViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SetupWizard2ViewController: FormViewController {

	var viewModelCast: SetupWizard2ViewModel!
	
	@IBOutlet weak var nhsOrSelfTitleLabel: UILabel!
	@IBOutlet weak var nhsButton: UIButton!
	@IBOutlet weak var selfPayButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nhsButton.setTitleColor(AppStyle.wizardNHSButtonColor, for: UIControlState.normal)
		selfPayButton.setTitleColor(AppStyle.wizardSelfPayButtonColor, for: UIControlState.normal)
		nhsButton.setBorder()
		selfPayButton.setBorder()
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		initViewModel(viewModel: SetupWizard2ViewModel())
	}
	
	// MARK: Bindings
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! SetupWizard2ViewModel)
		
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToSetupWizard3, sender: nil)
			}
		}
	}
	
	@IBAction func onNHSButtonPressed(_ sender: Any) {
		viewModelCast.isNHS = true
		viewModelCast.saveModel()
	}
	
	@IBAction func onSelfPayButtonPressed(_ sender: Any) {
		viewModelCast.isNHS = false
		viewModelCast.saveModel()
	}
	
	// MARK: Help
	
	func applyLocalization() {
		title = NSLocalizedString("setup_wizard2_main_vc_title", comment: "")
		
		nhsOrSelfTitleLabel.text = NSLocalizedString("setup_wizard2_nhs_or_self_pay_title", comment: "")
		
		nhsButton.setTitle(NSLocalizedString("setup_wizard2_nhs", comment: ""), for: .normal)
		
		selfPayButton.setTitle(NSLocalizedString("setup_wizard2_self_pay", comment: ""), for: .normal)

	}
}
