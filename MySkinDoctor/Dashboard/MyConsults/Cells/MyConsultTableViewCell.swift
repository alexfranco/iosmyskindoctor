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
		
		timeLabel.backgroundColor = AppStyle.consultTableViewCellTimeBackgroundColor
		timeLabel.textColor = AppStyle.consultTableViewCellTextColor
	}
	
	func configure(withViewModel viewModel: MyConsultTableViewCellViewModel) {
		contentView.backgroundColor = viewModel.tableViewCellBackgroundColor()
		nameLabel.text = viewModel.displayName
		timeLabel.text = viewModel.time
		timeLabel.setRounded()
		
		if let profileImageSafe = viewModel.profileImage {
			profileImageView.image = profileImageSafe
		} else {
			profileImageView.image = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		}
		
		profileImageView.setRounded()
		qualificationLabel.text = viewModel.qualification
		
		if viewModel.isInThePast {
			timeLabel.backgroundColor = AppStyle.consultTableViewCellTimeBackgroundColorDisabled
			timeLabel.textColor = AppStyle.consultTableViewCellTextColorDisabled
		} else {
			timeLabel.backgroundColor = AppStyle.consultTableViewCellTimeBackgroundColor
			timeLabel.textColor = AppStyle.consultTableViewCellTextColor
		}
	}
}
