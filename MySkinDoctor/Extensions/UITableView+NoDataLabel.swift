//
//  UITableView+NoDataLabel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

	func addNoDataLabel(labelText: String) {
		let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
		noDataLabel.text          = labelText
		noDataLabel.numberOfLines = 0
		noDataLabel.textColor     = UIColor.black
		noDataLabel.textAlignment = .center
		backgroundView  = noDataLabel
		separatorStyle  = .none
	}

	func removeNoDataLabel() {
		separatorStyle = .singleLine
		backgroundView = nil
	}
}
