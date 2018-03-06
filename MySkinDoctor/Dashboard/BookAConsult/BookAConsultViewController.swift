//
//  BookAConsultViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BookAConsultViewController: BindingViewController {
	@IBOutlet weak var cancelButton: UIBarButtonItem!
	@IBOutlet weak var preBookingInfoLabel: TitleLabel!
	@IBOutlet weak var doctorResponseLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("bookaconsult_main_vc_title", comment: "")
		
		preBookingInfoLabel.text = NSLocalizedString("bookaconsult_prebooking", comment: "")
		doctorResponseLabel.text = NSLocalizedString("bookaconsult_doctor_response", comment: "")
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
	}
	
}
