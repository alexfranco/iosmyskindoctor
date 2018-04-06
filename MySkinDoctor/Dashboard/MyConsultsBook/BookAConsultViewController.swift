//
//  BookAConsultViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 06/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookAConsultViewController: BindingViewController {
	
	@IBOutlet weak var cancelButton: UIBarButtonItem!
	@IBOutlet weak var preBookingInfoLabel: TitleLabel!
	@IBOutlet weak var doctorResponseLabel: UILabel!
	
	var skinProblemId: NSManagedObjectID!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("bookaconsult_main_vc_title", comment: "")
		
		preBookingInfoLabel.text = NSLocalizedString("bookaconsult_prebooking", comment: "")
		doctorResponseLabel.text = NSLocalizedString("bookaconsult_doctor_response", comment: "")
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
	}
	
	@IBAction func onCancelButtonPressed(_ sender : UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? BookAConsultCalendarViewController {
			vc.initViewModel(viewModel: BookAConsultCalendarViewModel(skinProblemsManagedObjectId: skinProblemId))
		}
	}
	
}
