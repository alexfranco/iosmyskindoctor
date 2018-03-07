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
		
		photoUtils = PhotoUtils.init(inViewController: self)
		
		title = NSLocalizedString("addskinproblems_main_vc_title", comment: "")
		
		descriptionTextView.placeholder = "Please enter the description of your skin problem, click on Add Photo"
		
//		self.nextButton.isEnabled = false
		
		configureTableView()
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
	
		viewModelCast.tableViewStageChanged = { [weak self] (tableViewState) in
			DispatchQueue.main.async {
				switch tableViewState {
				case .none:
					self?.tableView.reloadData()
				case let .insert(_, indexPath):
					self?.tableView.beginUpdates()
					self?.tableView.insertRows(at: [indexPath], with: .automatic)
					self?.tableView.endUpdates()
				case let .delete(indexPath):
					self?.tableView.beginUpdates()
					self?.tableView.deleteRows(at: [indexPath], with: .automatic)
					self?.tableView.endUpdates()
				}
			}
		}
		
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
		
		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				// TODO if the property save medical history for next time is true, it skips this step
				self?.performSegue(withIdentifier: Segues.goToMedicalHistoryViewControler, sender: nil)
//				self?.performSegue(withIdentifier: Segues.goToSkinProblemThankYouViewControllerFromAddSkinProblem, sender: nil)
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
				viewModelCast.appendNewModel(model: viewModel.model)
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
		return viewModelCast.getDataSourceCount()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if viewModelCast.getDataSourceCount() == indexPath.row + 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.addPhotoTableViewCellId) as! AddPhotoTableViewCell
			cell.configure(isFirstPhoto: viewModelCast.getDataSourceCount() == 1)
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.skinProblemTableViewCellId) as! SkinProblemTableViewCell
			let cellViewModel = SkinProblemTableCellViewModel(withModel: viewModelCast.getItemAtIndexPath(indexPath: indexPath))
			cell.configure(withViewModel: cellViewModel)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if viewModelCast.getDataSourceCount() == indexPath.row + 1 {
			// click on add photo
			photoUtils.showChoosePhoto { (success, image) in
				if success {
					self.performSegue(withIdentifier: Segues.goToSkinProblemPhotoInformationViewController, sender: image)
				}
			}
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return viewModelCast.getDataSourceCount() != indexPath.row + 1
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		viewModelCast.removeModel(at: indexPath)
	}
	
}
