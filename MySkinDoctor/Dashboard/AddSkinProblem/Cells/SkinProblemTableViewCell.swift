//
//  SkinProblemTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemTableViewCell: UITableViewCell {
	
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var problemImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		locationLabel.font = AppFonts.mediumFont
		descriptionLabel.font = AppFonts.defaultFont
		
		locationLabel.textColor = BaseColors.skyBlue		
		problemImageView.setRounded()
	}
	
	func configure(withViewModel viewModel: SkinProblemTableCellViewModel) {
		locationLabel.text = viewModel.location
		problemImageView.image = viewModel.problemImage
		descriptionLabel.text = viewModel.problemDescription
	}
}
