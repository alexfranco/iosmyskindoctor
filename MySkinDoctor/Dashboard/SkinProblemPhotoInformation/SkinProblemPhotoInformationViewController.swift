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
	
	@IBOutlet weak var descriptionLabel: GrayLabel!
	@IBOutlet weak var editButton: UIButton!
	
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { (self.viewModel as! SkinProblemPhotoInformationViewModel).problemDescription = $0 }
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("skinproblem_main_vc_title", comment: "")
		descriptionTextView.placeholder = "Please enter.... TODO"
		userPhotoImageView.image = (viewModel as! SkinProblemPhotoInformationViewModel).problemImage
		
		delegate = self
	}
	
	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		guard let viewModelSafe = viewModel as? SkinProblemPhotoInformationViewModel else { return }
		
		viewModelSafe.goNextSegue = { [] () in
			DispatchQueue.main.async {
				self.performSegue(withIdentifier: Segues.goToSkinProblemLocationViewController, sender: nil)
			}
		}
	}
	
	// MARK: IBAction
	
	@IBAction func onEditUserProfilePressed(_ sender: Any) {
		tapUserPhoto(nil)
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		(viewModel as? SkinProblemPhotoInformationViewModel)?.saveModel()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToSkinProblemLocationViewController {
			if let dest = segue.destination as? SkinProblemPhotoInformationViewController {
				let viewModelSafe = (viewModel as! SkinProblemPhotoInformationViewModel)
				dest.initViewModel(viewModel: SkinProblemLocationViewModel(model:  viewModelSafe.model))
			}
		}
	}
}

extension SkinProblemPhotoInformationViewController: PhotoViewControllerDelegate {
	
	func photoViewController(_ photoViewController: PhotoViewController, imageChanged: UIImage) {
		(self.viewModel as! SkinProblemPhotoInformationViewModel).problemImage = imageChanged
	}
}

