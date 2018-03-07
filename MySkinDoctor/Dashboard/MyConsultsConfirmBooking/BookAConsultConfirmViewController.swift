//
//  BookAConsultConfirmViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class BookAConsultConfirmViewController: BindingViewController {
	
	@IBOutlet weak var yourAppointmentDateTitleLabel: UILabel!
	@IBOutlet weak var yourAppointmentDateLabel: UILabel!
	@IBOutlet weak var yourAppointmentTimeTitleLabel: UILabel!
	@IBOutlet weak var yourAppointmentTimeLabel: UILabel!
	
	var viewModelCast: BookAConsultConfirmViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
			
		applyTheme()
		
		// default values
		yourAppointmentDateLabel.text = viewModelCast.dateLabelText
		yourAppointmentTimeLabel.text = viewModelCast.timeLabelText
	}
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! BookAConsultConfirmViewModel
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToThankYouViewController, sender: nil)
			}
		}
	}
	
	func applyTheme() {
		nextButton.backgroundColor = AppStyle.consultNextButtonBackgroundColor
		
		yourAppointmentDateLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
		yourAppointmentTimeLabel.textColor = AppStyle.consultConfirmHighligthedLabelTextColor
	}
	
	// MARK: IBActions
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToThankYouViewController {
			if let dest = segue.destination as? BookAConsultThankYouViewController, let model = viewModelCast.model {
				dest.initViewModel(viewModel: BookAConsultThankYouViewModel(model:  model))
			}
		}
	}
}
