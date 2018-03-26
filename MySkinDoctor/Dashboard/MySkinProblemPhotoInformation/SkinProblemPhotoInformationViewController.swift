//
//  SkinProblemPhotoInformationViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemPhotoInformationViewController: PhotoViewController {

	var viewModelCast : SkinProblemPhotoInformationViewModel!
	
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var skinBodyOptionButton: UIButton!
	@IBOutlet weak var documentOptionButton: UIButton!
	@IBOutlet weak var skinBodyInfoLabel: UILabel!
	@IBOutlet weak var documentInfoLabel: UILabel!
	
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { self.viewModelCast.problemDescription = $0 }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
		
		userPhotoImageView.image = viewModelCast.problemImage
		
		applyTheme()
		applyLocalization()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
	}

	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as? SkinProblemPhotoInformationViewModel
		
		viewModelCast.goPhotoLocation = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToSkinProblemLocationViewController, sender: nil)
			}
		}
		
		viewModelCast.unwind = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.unwindToAddSkinProblemsFromPhoto, sender: nil)
			}
		}
	}
	
	// MARK: IBAction
	
	@IBAction func onEditUserProfilePressed(_ sender: Any) {
		tapUserPhoto(nil)
	}
	
	@IBAction func onBodyOptionPressed(_ sender: Any) {
		viewModelCast.saveModel(attachmentType: .photo)
	}
	
	@IBAction func onDocumentOptionPressed(_ sender: Any) {
		viewModelCast.saveModel(attachmentType: .document)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToSkinProblemLocationViewController {
			if let dest = segue.destination as? SkinProblemLocationViewController {
				dest.initViewModel(viewModel: SkinProblemLocationViewModel(model:  viewModelCast.model))
			}
		}
	}
	
	// MARK: Helpers
	func applyTheme() {
		skinBodyOptionButton.backgroundColor = AppStyle.addSkinPhotoBodyButtonBackgroundColor
		documentOptionButton.backgroundColor = AppStyle.addSkinPhotoDocumentButtonBackgroundColor
		
		editButton.setTitleColor(AppStyle.addSkinPhotoEditTextColor, for: .normal)
		skinBodyOptionButton.setTitleColor(AppStyle.addSkinPhotoTypeTextColor, for: .normal)
		documentOptionButton.setTitleColor(AppStyle.addSkinPhotoTypeTextColor, for: .normal)
		
		editButton.titleLabel?.font = AppStyle.addSkinPhotoTextFont
		skinBodyOptionButton.titleLabel?.font = AppStyle.addSkinPhotoTextFont
		documentOptionButton.titleLabel?.font = AppStyle.addSkinPhotoTextFont
		
		skinBodyOptionButton.setRounded()
		documentOptionButton.setRounded()
	}
	
	func applyLocalization() {
		descriptionTextView.placeholder =  NSLocalizedString("skinproblems_photo_information_description_text_view", comment: "")
		skinBodyInfoLabel.text = NSLocalizedString("skinproblems_photo_information_photo_type", comment: "")
		documentInfoLabel.text = NSLocalizedString("skinproblems_photo_information_document_type", comment: "")
	}
}

extension SkinProblemPhotoInformationViewController: PhotoViewControllerDelegate {
	
	func photoViewController(_ photoViewController: PhotoViewController, imageChanged: UIImage) {
		viewModelCast.problemImage = imageChanged
	}
}

