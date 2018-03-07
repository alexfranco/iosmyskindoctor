//
//  SkinProblemLocationViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemLocationViewController: FormViewController {
	
	@IBOutlet weak var frontBackSegmentedControl: UISegmentedControl!
	@IBOutlet weak var tipLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var bodyImageView: UIImageView!
	@IBOutlet weak var locationHeadButton: UIButton!
	@IBOutlet weak var locationNeckButton: UIButton!
	
	var viewModelCast: SkinProblemLocationViewModel!
	var locationButtons: [UIButton]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.locationNavigationBarBackgroundColor, titleColor: AppStyle.locationTextColor)
		
		view.backgroundColor = AppStyle.locationBackgroundColor
		frontBackSegmentedControl.tintColor = AppStyle.locationSegmentedControlTint
		frontBackSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.locationSegmentedControlUnselectedTextColor], for: .normal)
		frontBackSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.locationSegmentedControlSelectedTextColor], for: .selected)
		locationLabel.textColor = AppStyle.locationTextColor
		tipLabel.textColor = AppStyle.locationTextColor
		
		viewModelCast.isFrontSelected = frontBackSegmentedControl.selectedSegmentIndex == 0
		locationLabel.text = viewModelCast.problemLocationText

		configureLocationButtons()
		
		self.nextButton.isEnabled = false
	}

	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! SkinProblemLocationViewModel)
		
		viewModelCast.bodyImageChanged = { [] (isFrontSelected, bodyImage) in
			DispatchQueue.main.async {
				self.bodyImageView.image = bodyImage
			}
		}
		
		viewModelCast.locationProblemUpdated = { [] (locationProblemType) in
			DispatchQueue.main.async {
				self.nextButton.isEnabled = true
				self.selectLocationButton(locationProblemType: locationProblemType)
				self.locationLabel.text = self.viewModelCast.problemLocationText
			}
		}
		
		viewModelCast.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.unwindToAddSkinProblems, sender: nil)
			}
		}
	}
	
	// MARK: Helpers
		
	func configureLocationButtons() {
		locationHeadButton.tag = SkinProblemModel.LocationProblemType.head.index
		locationNeckButton.tag = SkinProblemModel.LocationProblemType.neck.index
		
		locationButtons = [locationHeadButton, locationNeckButton]
	}
	
	func selectLocationButton(locationProblemType: SkinProblemModel.LocationProblemType) {
		for button in locationButtons {
			button.isSelected = button.tag == locationProblemType.index
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onfrontBackSegmentedControlValueChanged(_ sender: Any) {
		viewModelCast.isFrontSelected = frontBackSegmentedControl.selectedSegmentIndex == 0
	}
	
	@IBAction func onLocationPressed(_ sender: Any) {
		if let button = sender as? UIButton {
			button.isSelected = true
			let locationProblemRawValue = button.tag
			viewModelCast.locationProblemType = SkinProblemModel.LocationProblemType(rawValue: locationProblemRawValue)!
		}
	}
		
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
}
