//
//  MySkinProblemsTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsTableViewCell: UITableViewCell {
	
	let diagnosedImageName = "diagnosed"
	let undiagnosedImageName = "undiagnosed"
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var statusImageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	func configure(withViewModel viewModel: MySkinProblemsTableCellViewModel) {
		nameLabel.text = viewModel.name
		
		dateLabel.text = viewModel.date
		dateLabel.textColor = viewModel.isDiagnosed ? AppStyle.mySkinDiagnosedColor : AppStyle.mySkinUndiagnosedColor
		
		statusImageView.image = viewModel.isDiagnosed ? UIImage(named: diagnosedImageName) : UIImage(named: undiagnosedImageName)
		descriptionLabel.text = viewModel.problemDescription
	}
}
