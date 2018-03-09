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
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var problemImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		nameLabel.font = AppFonts.mediumFont
		locationLabel.font = AppFonts.mediumFont
		descriptionLabel.font = AppFonts.defaultFont
		
		locationLabel.textColor = BaseColors.skyBlue		
		problemImageView.setRounded()
	}
	
	func configure(withViewModel viewModel: SkinProblemTableCellViewModel) {
		nameLabel.text = viewModel.name
		locationLabel.text = viewModel.location
		problemImageView.image = viewModel.problemImage
		problemImageView.contentMode = .scaleAspectFill
		descriptionLabel.text = viewModel.problemDescription
	}
}
