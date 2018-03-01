//
//  AddSkinProblemsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinProblemsViewController: BindingViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var descriptionLabel: GrayLabel!
	
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { self.viewModelCast.skinProblemDescription = $0 }
		}
	}
	
	var photoUtils: PhotoUtils!
	var viewModelCast: AddSkinProblemsViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("addskinproblems_main_vc_title", comment: "")
		
		descriptionTextView.placeholder = "Please enter.... TODO"
		
		configureTableView()
		photoUtils = PhotoUtils.init(inViewController: self)
		
		self.nextButton.isEnabled = false
		
		initViewModel(viewModel: AddSkinProblemsViewModel())
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
	}
	
	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as? AddSkinProblemsViewModel
	
		viewModelCast.updateNextButton = { [weak self] (isEnabled) in
			DispatchQueue.main.async {
				self?.nextButton.isEnabled = isEnabled
			}
		}
		
		viewModelCast.refresh = { [weak self] () in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToSkinProblemPhotoInformationViewController {
			if let dest = segue.destination as? SkinProblemPhotoInformationViewController, let image = sender as? UIImage {
				let skinProblem = SkinProblemModel(problemImage: image) // create new skin problem with the image attached
				dest.initViewModel(viewModel: SkinProblemPhotoInformationViewModel(model:  skinProblem))
			}
		}
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToAddSkinProblems(segue: UIStoryboardSegue) {
		if let sourceViewController = segue.source as? SkinProblemLocationViewController {
			if let viewModel = sourceViewController.viewModelCast {
				viewModelCast.addNewModel(model: viewModel.model)
			}
		}
	}
}

extension AddSkinProblemsViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModelCast.getNumberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModelCast.getDataSourceCount(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if viewModelCast.getDataSourceCount(section: indexPath.section) == indexPath.row + 1 {
			return tableView.dequeueReusableCell(withIdentifier: CellId.addPhotoTableViewCellId) as! AddPhotoTableViewCell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.skinProblemTableViewCellId) as! SkinProblemTableViewCell
			let cellViewModel = SkinProblemTableCellViewModel(withModel: viewModelCast.getItemAtIndexPath(indexPath: indexPath))
			cell.configure(withViewModel: cellViewModel)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if viewModelCast.getDataSourceCount(section: indexPath.section) == indexPath.row + 1 {
			// click on add photo
			photoUtils.showChoosePhoto { (success, image) in
				if success {
					self.performSegue(withIdentifier: Segues.goToSkinProblemPhotoInformationViewController, sender: image)
				}
			}
		} else {
			// click on skin problem, go to see details
		}
	}
	
}

