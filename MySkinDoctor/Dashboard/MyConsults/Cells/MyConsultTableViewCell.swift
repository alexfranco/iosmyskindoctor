//
//  MyConsultTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MyConsultTableViewCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var qualificationLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		timeLabel.backgroundColor = AppStyles.consultTableViewCellTimeBackgroundColor
		timeLabel.textColor = AppStyles.consultTableViewCellTextColor
	}
	
	func configure(withViewModel viewModel: MyConsultTableViewCellViewModel) {
		nameLabel.text = viewModel.name
		
		dateLabel.text = viewModel.date
		dateLabel.textColor = viewModel.isDiagnosed ? AppStyle.mySkinDiagnosedColor : AppStyle.mySkinUndiagnosedColor
		
		statusImageView.image = viewModel.isDiagnosed ? UIImage(named: diagnosedImageName) : UIImage(named: undiagnosedImageName)
		descriptionLabel.text = viewModel.problemDescription
	}
}
