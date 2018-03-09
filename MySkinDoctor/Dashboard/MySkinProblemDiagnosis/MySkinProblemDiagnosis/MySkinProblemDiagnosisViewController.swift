//
//  MySkinProblemDiagnoseViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 08/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnosisViewController: BaseMySkinProblemDiagnosisViewController {
	
	@IBOutlet weak var diagnosisTitleLabel: TitleLabel!
	@IBOutlet weak var diagnosisDetailsLabel: UILabel!
	@IBOutlet weak var treatmentTitleLabel: TitleLabel!
	@IBOutlet weak var treatmentDetailsLabel: UILabel!
	@IBOutlet weak var patientInfoTitleLabel: TitleLabel!
	@IBOutlet weak var patientInfoDetailsLabel: UILabel!
	@IBOutlet weak var commentsTitleLabel: TitleLabel!
	@IBOutlet weak var commentsDetailsLabel: UILabel!
	@IBOutlet weak var scrollView: UIScrollView!

	var viewModelCast: MySkinProblemDiagnosisViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MySkinProblemDiagnosisViewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		diagnosisDetailsLabel.text = viewModelCast.diagnosis
		treatmentDetailsLabel.text = viewModelCast.treatment
		patientInfoDetailsLabel.text = viewModelCast.patientInformation
		commentsDetailsLabel.text = viewModelCast.comments		
	}
	
	override func applyTheme() {
		super.applyTheme()
		
		diagnosisTitleLabel.textColor = AppStyle.diagnoseTitleColor
		treatmentTitleLabel.textColor = AppStyle.diagnoseTitleColor
		patientInfoTitleLabel.textColor = AppStyle.diagnoseTitleColor
		commentsTitleLabel.textColor = AppStyle.diagnoseTitleColor
		scrollView.backgroundColor = viewModelCast.viewBackgroundColor
	}
}


