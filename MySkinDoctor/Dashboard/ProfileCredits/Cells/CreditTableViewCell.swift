//
//  CreditTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class CreditTableViewCell: UITableViewCell {
	
	@IBOutlet weak var creditLabel: UILabel!
	@IBOutlet weak var buyForLabel: UILabel!
	@IBOutlet weak var buyButton: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		creditLabel.font = AppFonts.bigBoldFont
		buyForLabel.font = AppFonts.mediumFont		
	}
	
	func configure(withViewModel viewModel: CreditTableViewModel) {
		creditLabel.text = viewModel.creditsText
		buyForLabel.text = viewModel.buyForText
	}
}
