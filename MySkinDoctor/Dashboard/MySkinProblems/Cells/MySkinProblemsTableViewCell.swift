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
	
	func configure(withViewModel viewModel: MySkinProblemsTableCellViewModel) {
		nameLabel.text = viewModel.name
	}
}
