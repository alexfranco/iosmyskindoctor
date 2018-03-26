//
//  SkinProblemThankYouViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemThankYouViewController: UIViewController {
	
	@IBOutlet weak var thankYouLabel: UILabel!
	@IBOutlet weak var diagnosisLabel: UILabel!
	@IBOutlet weak var closeButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = AppStyle.thankYouBackground
		thankYouLabel.textColor = AppStyle.thankYouTextColor
		diagnosisLabel.textColor = AppStyle.thankYouTextColor
		closeButton.setTitleColor(AppStyle.thankYouTextColor, for: UIControlState.normal)
		
		applyTheme()
		applyLocaliation()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: IBActions
	
	@IBAction func onClosebuttonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Helpers
	func applyTheme() {
		thankYouLabel.font = AppFonts.veryBigFont
		diagnosisLabel.font = AppFonts.mediumFont
	}
	
	func applyLocaliation() {
		thankYouLabel.text = NSLocalizedString("skinproblem_thank_you", comment: "")
		diagnosisLabel.text = NSLocalizedString("skinproblem_diagnosis", comment: "")
		closeButton.setTitle(NSLocalizedString("close", comment: ""), for: .normal)
	}
}
