//
//  AddPhotoTableViewCell.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddPhotoTableViewCell: UITableViewCell {
	
	@IBOutlet weak var addPhotoLabel: UILabel!
	@IBOutlet weak var addPhotoButton: UIButton!
	
	func configure(isFirstPhoto: Bool) {
		addPhotoLabel.text = isFirstPhoto ? "Add photo" : "Add another photo"
	}
}
