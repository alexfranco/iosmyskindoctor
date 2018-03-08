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
	
	@IBOutlet weak var undiagnosedStatusView: UIView!
	@IBOutlet weak var undiagnosedImageView: UIImageView!
	@IBOutlet weak var undiagnosedViewHeight: NSLayoutConstraint!
	@IBOutlet weak var undiagnosedInfoLabel: UILabel!
	
	@IBOutlet weak var diagnosedStatusView: UIView!
	@IBOutlet weak var diagnosedImageView: UIImageView!
	@IBOutlet weak var diagnosedViewHeight: NSLayoutConstraint!
	@IBOutlet weak var diagnosedInfoLabel: UILabel!
	@IBOutlet weak var diagnosedViewButton: UIButton!
	
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var descriptionLabel: GrayLabel!
	@IBOutlet weak var descriptionLabelTop: NSLayoutConstraint!
	
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { self.viewModelCast.skinProblemDescription = $0 }
		}
	}
	
	var photoUtils: PhotoUtils!
	var viewModelCast: AddSkinProblemsViewModel!
	
	let diagnosedViewHeightDefault = CGFloat(80)
	let descriptionLabelTopDefault = CGFloat(5)
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as? AddSkinProblemsViewModel
		
		viewModelCast.diagnosedStatusChanged = { [weak self] (status) in
			DispatchQueue.main.async {
				self?.showHideDiagnoseViews(diagnoseStatus: status)
			}
		}
		
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		photoUtils = PhotoUtils.init(inViewController: self)
		
		descriptionTextView.placeholder = "Please enter the description of your skin problem, click on Add Photo"
		
		nextButton.isEnabled = false
		
		configureTableView()
		configureDiagnoseView()

		reloadUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
	}
	
	// MARK: Helpers
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	func configureDiagnoseView() {
		undiagnosedStatusView.backgroundColor = AppStyle.addSkinProblemUndiagnosedViewBackground
		undiagnosedInfoLabel.textColor = AppStyle.addSkinProblemUndiagnosedTextColor
		diagnosedStatusView.backgroundColor = AppStyle.addSkinProblemDiagnosedViewBackground
		diagnosedInfoLabel.textColor = AppStyle.addSkinProblemDiagnosedTextColor
		diagnosedViewButton.setTitleColor(AppStyle.addSkinProblemDiagnosedTextColor, for: .normal)
	}
	
	func reloadUI() {
		// fill in values
		title = viewModelCast.navigationTitle
		
		descriptionTextView.isEditable = viewModelCast.isEditEnabled
		descriptionTextView.text = viewModelCast.skinProblemDescription
		diagnosedInfoLabel.text = viewModelCast.diagnoseInfoText
		
		// if we are in no edit mode, we don't need to show the place holder here.
		if !viewModelCast.isEditEnabled {
			descriptionTextView.placeholder = ""
		}
		
		showHideDiagnoseViews(diagnoseStatus: viewModelCast.diagnoseStatus)
		nextButton.isHidden = !viewModelCast.isEditEnabled
		
		tableView.reloadData()
	}
	
	func showHideDiagnoseViews(diagnoseStatus: Diagnose.DiagnoseStatus) {
		undiagnosedViewHeight.constant = diagnoseStatus == .noDiagnosed ? diagnosedViewHeightDefault : 0
		undiagnosedImageView.isHidden = diagnoseStatus != .noDiagnosed
		undiagnosedInfoLabel.isHidden = diagnoseStatus != .noDiagnosed
		
		diagnosedViewHeight.constant = diagnoseStatus == .diagnosed ? diagnosedViewHeightDefault : 0
		diagnosedImageView.isHidden = diagnoseStatus != .diagnosed
		diagnosedInfoLabel.isHidden = diagnoseStatus != .diagnosed
		diagnosedViewButton.isHidden = diagnoseStatus != .diagnosed
		
		descriptionLabelTop.constant = diagnoseStatus == .none ? descriptionLabelTopDefault : descriptionLabelTopDefault + diagnosedViewHeightDefault
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel()
	}
	
	@IBAction func onViewDiagnosePressed(_ sender: Any) {
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
		if viewModelCast.isAddPhotoRow(indexPath: indexPath) {
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
		
		if viewModelCast.isAddPhotoRow(indexPath: indexPath) {
			// click on add photo
			photoUtils.showChoosePhoto { (success, image) in
				if success {
					self.performSegue(withIdentifier: Segues.goToSkinProblemPhotoInformationViewController, sender: image)
				}
			}
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return viewModelCast.canEditRow(indexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		viewModelCast.removeModel(at: indexPath)
	}
}

