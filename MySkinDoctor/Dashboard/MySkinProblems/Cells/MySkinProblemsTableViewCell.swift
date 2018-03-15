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
		
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var statusImageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	func configure(withViewModel viewModel: MySkinProblemsTableCellViewModel) {
		contentView.backgroundColor = viewModel.tableViewBackground
		nameLabel.text = viewModel.name
		dateLabel.text = viewModel.date
		dateLabel.textColor = viewModel.diagnoseTextColor
		statusImageView.image = viewModel.icon
		descriptionLabel.text = viewModel.problemDescription
	}
}
