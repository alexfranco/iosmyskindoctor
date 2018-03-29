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
	
	@IBOutlet weak var tipLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var bodyImageView: UIImageView!
	@IBOutlet weak var locationHeadButton: UIButton!
	@IBOutlet weak var locationNeckButton: UIButton!
	@IBOutlet weak var locationChestButton: UIButton!
	@IBOutlet weak var locationBellyButton: UIButton!
	@IBOutlet weak var locationUpperArmLeftButton: UIButton!
	@IBOutlet weak var locationUpperArmRightButton: UIButton!
	@IBOutlet weak var locationLowerArmLeftButton: UIButton!
	@IBOutlet weak var locationLowerArmRightButton: UIButton!
	@IBOutlet weak var locationPelvisButton: UIButton!
	@IBOutlet weak var locationUpperLegLeftButton: UIButton!
	@IBOutlet weak var locationUpperLegRightButton: UIButton!
	@IBOutlet weak var locationLowerLegLeftButton: UIButton!
	@IBOutlet weak var locationLowerLegRightButton: UIButton!
	@IBOutlet weak var locationFootLeftButton: UIButton!
	@IBOutlet weak var locationFootRightButton: UIButton!
	@IBOutlet weak var bodyLeftButton: UIButton!
	@IBOutlet weak var bodyRightButton: UIButton!
	
	var viewModelCast: SkinProblemLocationViewModel!
	var locationButtons: [UIButton]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModelCast.isFrontSelected = true
		nextButton.isEnabled = false
		
		configureLocationButtons()
		applyTheme()
		applyLocalization()
	}

	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = (viewModel as! SkinProblemLocationViewModel)
		
		viewModelCast.bodyImageChanged = { [weak self] (isFrontSelected, bodyImage) in
			DispatchQueue.main.async {
				self?.bodyImageView.image = bodyImage
				self?.bodyLeftButton.isHidden = (self?.viewModelCast.isFrontSelected)!
				self?.bodyRightButton.isHidden = !(self?.viewModelCast.isFrontSelected)!
			}
		}
		
		viewModelCast.locationProblemUpdated = { [weak self] (locationProblemType) in
			DispatchQueue.main.async {
				self?.nextButton.isEnabled = true
				
				var finalLocationProblemType = locationProblemType
				
				if !(self?.viewModelCast.isFrontSelected)! {
					finalLocationProblemType = SkinProblemAttachment.convertLocationTypePosteriorToAnterior(type: locationProblemType)
				}
				
				self?.selectLocationButton(locationProblemType: finalLocationProblemType)
				self?.locationLabel.text = self?.viewModelCast.problemLocationText
			}
		}
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.unwindToAddSkinProblems, sender: nil)
			}
		}
	}
	
	func selectLocationButton(locationProblemType: SkinProblemAttachment.LocationProblemType) {
		for button in locationButtons {
			button.isSelected = button.tag == SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: locationProblemType)
		}
	}
	
	// MARK: IBActions
	
	@IBAction func onBodyLrftButtonPressed(_ sender: Any) {
		viewModelCast.isFrontSelected = true
	}
	
	@IBAction func onBodyRightButtonPressed(_ sender: Any) {
		viewModelCast.isFrontSelected = false
	}
	
	@IBAction func onLocationPressed(_ sender: Any) {
		if let button = sender as? UIButton {
			button.isSelected = true
			let locationProblemRawValue = button.tag
			var finalLocation = SkinProblemAttachment.LocationProblemType.element(at: locationProblemRawValue) ?? .none
			if !viewModelCast.isFrontSelected {
				finalLocation = SkinProblemAttachment.convertLocationTypeAnteriorToPosterior(type: finalLocation)
			}
			
			viewModelCast.locationProblemType = finalLocation
		}
	}
		
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	// MARK: Helpers
	
	func configureLocationButtons() {
		locationHeadButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .headAnterior)
		locationNeckButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .neckAnterior)
		locationChestButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .chestAnterior)
		locationBellyButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .abdomenAnterior)
		locationUpperArmLeftButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .upperArmLeft)
		locationUpperArmRightButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .upperArmRight)
		locationLowerArmLeftButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .lowerArmLeft)
		locationLowerArmRightButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .lowerArmRight)
		
		locationPelvisButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .pubicAndGroinAnterior)
		locationUpperLegLeftButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType:.upperLegLeftAnterior)
		locationUpperLegRightButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .upperLegRightAnterior)
		locationLowerLegLeftButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType: .lowerLegLeftAnterior)
		locationLowerLegRightButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType:.lowerLegRightAnterior)
		locationFootLeftButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType:.footLeftAnterior)
		locationFootRightButton.tag = SkinProblemAttachment.LocationProblemType.indexOf(locationProblemType:.footRightAnterior)
		
		locationButtons = [locationHeadButton,
						   locationNeckButton,
						   locationChestButton,
						   locationBellyButton,
						   locationUpperArmLeftButton,
						   locationUpperArmRightButton,
						   locationLowerArmLeftButton,
						   locationLowerArmRightButton,
						   locationPelvisButton,
						   locationUpperLegLeftButton,
						   locationUpperLegRightButton,
						   locationLowerLegLeftButton,
						   locationLowerLegRightButton,
						   locationFootLeftButton,
						   locationFootRightButton]
	}
	
	func applyTheme() {
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.locationNavigationBarBackgroundColor, titleColor: AppStyle.locationTextColor)
		
		view.backgroundColor = AppStyle.locationBackgroundColor
		locationLabel.textColor = AppStyle.locationTextColor
		tipLabel.textColor = AppStyle.locationTextColor
		locationLabel.text = viewModelCast.problemLocationText
	}
	
	func applyLocalization() {
		title = NSLocalizedString("skinproblems_photo_information_main_vc_title", comment: "")
		tipLabel.text = NSLocalizedString("addskinproblems_location_tip", comment: "")
		nextButton.setTitle(NSLocalizedString("addskinproblems_location_next_button", comment: ""), for: .normal)
	}
	
}
