//
//  MySkinProblemDiagnoseUpdateRequestTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnoseUpdateRequestTableViewCell: UITableViewCell {
	
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var noteLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		dateLabel.font = AppFonts.mediumFont
		noteLabel.font = AppFonts.defaultFont
	}
	
	func configure(withViewModel viewModel:MySkinProblemDiagnoseUpdateRequestTableViewModel) {
		dateLabel.text = viewModel.date
		noteLabel.text = viewModel.note
	}
}

