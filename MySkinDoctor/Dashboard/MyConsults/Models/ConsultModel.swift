//
//  ConsultModel.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ConsultModel: NSObject {
	var profileImage: UIImage?
	var firstName: String?
	var lastName: String?
	var date: Date?
	var qualification: String?
	
	required init(profileImage: UIImage?, firstName: String?, lastName: String?, date: Date?, qualification: String?) {
		super.init()
		self.profileImage = profileImage
		self.firstName = firstName
		self.lastName = lastName
		self.date = date
		self.qualification = qualification
	}
}
