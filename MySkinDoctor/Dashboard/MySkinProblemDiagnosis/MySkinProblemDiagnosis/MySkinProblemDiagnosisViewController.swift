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

	@IBOutlet weak var informationSheetsLabel: UILabel!
	@IBOutlet weak var informationSheetsStackView: UIStackView!
	
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
		
		loadInformationSheets()
	}
	
	override func applyTheme() {
		super.applyTheme()
		
		diagnosisTitleLabel.textColor = AppStyle.diagnoseTitleColor
		treatmentTitleLabel.textColor = AppStyle.diagnoseTitleColor
		patientInfoTitleLabel.textColor = AppStyle.diagnoseTitleColor
		commentsTitleLabel.textColor = AppStyle.diagnoseTitleColor
		informationSheetsStackView.backgroundColor = AppStyle.diagnoseInformationSheetBackgroundColor
		informationSheetsLabel.backgroundColor = AppStyle.diagnoseInformationSheetBackgroundColor
		informationSheetsLabel.textColor = AppStyle.diagnoseInformationTextcolor
		informationSheetsLabel.font = AppFonts.bigBoldFont
	}
	
	func loadInformationSheets() {
		for index in 0..<viewModelCast.getDataSourceCount() {
			addInformationSheetRow(index: index)
		}
	}
	
	func addInformationSheetRow(index: Int) {
		// Sheet View
		let sheetButton = UIButtonCustomHighlight(frame: CGRect(x: 0, y: 0, width: informationSheetsStackView.frame.size.width, height: 60))
		sheetButton.isUserInteractionEnabled = true
		sheetButton.backgroundColor = AppStyle.diagnoseInformationSheetBackgroundColor
		sheetButton.normalBackgroundColor = AppStyle.diagnoseInformationSheetBackgroundColor
		sheetButton.hightlightBackgroundColor = AppStyle.diagnoseInformationSheetHightlightBackgroundColor
		
		sheetButton.translatesAutoresizingMaskIntoConstraints = false
		sheetButton.addConstraint(NSLayoutConstraint(item: sheetButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
		sheetButton.tag = index
		sheetButton.addTarget(self, action:#selector(onDiagnoseAttachmentPressed), for: .touchUpInside)
		informationSheetsStackView.addArrangedSubview(sheetButton)
		
		// Icon Image
		let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 20))
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		iconImageView.image = UIImage(named: "documentGreen")
		iconImageView.isUserInteractionEnabled = false
		sheetButton.addSubview(iconImageView)
		
		sheetButton.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: sheetButton, attribute: .leading, multiplier: 1.0, constant: 30))
		sheetButton.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: sheetButton, attribute: .centerY, multiplier: 1.0, constant: 0))
		
		// Title
		let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = viewModelCast.getAttachmentNameAtIndex(index: index)
		titleLabel.isUserInteractionEnabled = false
		titleLabel.textColor = AppStyle.diagnoseInformationTextcolor
		sheetButton.addSubview(titleLabel)
		
		sheetButton.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: iconImageView, attribute: .leading, multiplier: 1.0, constant: 30))
		sheetButton.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: sheetButton, attribute: .trailing, multiplier: 1.0, constant: 10))
		sheetButton.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: iconImageView, attribute: .centerY, multiplier: 1.0, constant: 0))
	}
	
	@objc func onDiagnoseAttachmentPressed(_ sender : UIButton) {
		print(sender.tag)
		viewModelCast.openAttachment(index: sender.tag)
	}
}


