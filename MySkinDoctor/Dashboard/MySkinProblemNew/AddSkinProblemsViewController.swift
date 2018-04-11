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
	
	@IBOutlet weak var cancelButton: UIBarButtonItem!
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
				self?.reloadUI()
				self?.showHideDiagnoseViews()
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
		
		viewModelCast.onSkinProblemAttachmentImageAdded = { [weak self] (skinProblemAttachment) in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToSkinProblemPhotoInformationViewController, sender: skinProblemAttachment)
			}
		}

		viewModelCast.goNextSegue = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.goToMedicalHistoryViewControler, sender: nil)
			}
		}
		
		viewModelCast.onSaveLaterSuccess = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.unwindToMySkinProblems, sender: nil)
			}
		}
		
		viewModelCast.onModelDiscarted = { [weak self] () in
			DispatchQueue.main.async {
				self?.performSegue(withIdentifier: Segues.unwindToMySkinProblems, sender: nil)
			}
		}
		
		navigationController?.title = viewModelCast.navigationTitle
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		photoUtils = PhotoUtils.init(inViewController: self)
		
		configureTableView()
		configureDiagnoseView()

		reloadUI()
		
		applyLocalization()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		navigationController?.title = viewModelCast.navigationTitle
		
		nextButton.isEnabled = false
	}
	
	// MARK: Helpers
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	func configureDiagnoseView() {
		undiagnosedStatusView.backgroundColor = viewModelCast.infoViewBackground
		undiagnosedInfoLabel.textColor = AppStyle.addSkinProblemInfoViewTextColor
		
		diagnosedStatusView.backgroundColor = viewModelCast.infoViewBackground
		diagnosedInfoLabel.textColor = AppStyle.addSkinProblemInfoViewTextColor
		diagnosedViewButton.setTitleColor(AppStyle.addSkinProblemInfoViewTextColor, for: .normal)
	}
	
	func reloadUI() {
		// fill in values
		title = viewModelCast.navigationTitle
		
		descriptionTextView.isEditable = viewModelCast.isEditEnabled
		descriptionTextView.text = viewModelCast.skinProblemDescription
		undiagnosedInfoLabel.text = viewModelCast.diagnoseInfoText
		diagnosedInfoLabel.text = viewModelCast.diagnoseInfoText
		
		// if we are in no edit mode, we don't need to show the place holder here.
		if !viewModelCast.isEditEnabled {
			descriptionTextView.placeholder = ""
		}
		
		showHideDiagnoseViews()
		nextButton.isHidden = !viewModelCast.isEditEnabled
		nextButton.isEnabled = viewModelCast.nextButtonIsEnabled

		tableView.reloadData()
	}
	
	func showHideDiagnoseViews() {
		descriptionLabelTop.constant = viewModelCast.diagnoseStatus == .draft ? descriptionLabelTopDefault : descriptionLabelTopDefault + diagnosedViewHeightDefault
		
		undiagnosedViewHeight.constant = viewModelCast.diagnoseStatus == .submitted ? diagnosedViewHeightDefault : 0
		undiagnosedImageView.isHidden = viewModelCast.diagnoseStatus != .submitted
		undiagnosedInfoLabel.isHidden = viewModelCast.diagnoseStatus != .submitted
		
		diagnosedViewHeight.constant = viewModelCast.isDiagnosed ? diagnosedViewHeightDefault : 0
		diagnosedImageView.isHidden = !viewModelCast.isDiagnosed
		diagnosedInfoLabel.isHidden = !viewModelCast.isDiagnosed
		diagnosedViewButton.isHidden = !viewModelCast.isDiagnoseViewButtonVisible
	}
	
	@IBAction func onNextButtonPressed(_ sender: Any) {
		viewModelCast.saveModel(saveLater: false)
	}
	
	@IBAction func onViewDiagnosePressed(_ sender: Any) {
		self.performSegue(withIdentifier: viewModelCast.diagnoseNextSegue, sender: nil)
	}
	
	@IBAction func onCancelButtonPressed(_ sender: Any) {
		if viewModelCast.shouldShowCancelAlert() {
			let alertController = UIAlertController (
				title: "",
				message: NSLocalizedString("addskinproblems_question", comment: ""),
				preferredStyle: .alert)
			
			let continueAction = UIAlertAction(title: NSLocalizedString("addskinproblems_continue_editing", comment: "Close button"), style: .default) { (action) in
			}
			
			let saveLaterAction = UIAlertAction(title: NSLocalizedString("addskinproblems_save_later", comment: "Close button"), style: .default) { (action) in
				self.viewModelCast.saveModel(saveLater: true)
			}
			
			let discardAction = UIAlertAction(title: NSLocalizedString("addskinproblems_discard", comment: "Close button"), style: .destructive) { (action) in
				self.viewModelCast.discardModel()
			}
			
			alertController.addAction(discardAction)
			alertController.addAction(continueAction)
			alertController.addAction(saveLaterAction)
			self.present(alertController, animated: true) {}
		} else {
			self.performSegue(withIdentifier: Segues.unwindToMySkinProblems, sender: nil)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToSkinProblemPhotoInformationViewController {
		if let dest = segue.destination as? SkinProblemPhotoInformationViewController, let skinProblemAttachment = sender as? SkinProblemAttachment {
				dest.initViewModel(viewModel: SkinProblemPhotoInformationViewModel(model:  skinProblemAttachment))
			}
		} else if segue.identifier == Segues.goToDiagnosis {
			if let dest = segue.destination as? MySkinProblemDiagnosisViewController {
				dest.initViewModel(viewModel: MySkinProblemDiagnosisViewModel(modelId: (self.viewModelCast.model?.objectID)!))
			}
		} else if segue.identifier == Segues.goToMySkinProblemDiagnoseUpdateRequest {
			if let dest = segue.destination as? MySkinProblemDiagnoseUpdateRequestViewController {
				dest.initViewModel(viewModel: MySkinProblemDiagnoseUpdateRequestViewModel(modelId: (self.viewModelCast.model?.objectID)!))
			}
		} else if segue.identifier == Segues.goToMedicalHistoryViewControler {
			if let dest = segue.destination as? MedicalHistoryViewControler {
				dest.initViewModel(viewModel: MedicalHistoryViewModel(modelId: (self.viewModelCast.model?.objectID)!))
			}
		}
	}
	
	// MARK: Helpers	
	func applyLocalization() {
		nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
		cancelButton.title = NSLocalizedString("cancel", comment: "")
		descriptionTextView.placeholder = NSLocalizedString("addskinproblems_description", comment: "")
		diagnosedViewButton.setTitle(NSLocalizedString("addskinproblems_view", comment: ""), for: .normal)
	}
	
	// MARK: Unwind
	
	@IBAction func unwindToAddSkinProblems(segue: UIStoryboardSegue) {
		if let sourceViewController = segue.source as? SkinProblemLocationViewController {
			if let viewModel = sourceViewController.viewModelCast {				
				viewModelCast.insertAttachment(skinProblemAttachment: viewModel.model)
			}
		}
	}
	
	@IBAction func unwindToAddSkinProblemsFromPhoto(segue: UIStoryboardSegue) {
		if let sourceViewController = segue.source as? SkinProblemPhotoInformationViewController {
			if let viewModel = sourceViewController.viewModelCast {
				viewModelCast.insertAttachment(skinProblemAttachment: viewModel.model)
			}
		}
	}
	
	@IBAction func unwindToAddSkinProblemsFromMedicalHistory(segue: UIStoryboardSegue) {
		if let _ = segue.source as? MedicalHistoryViewControler {
			viewModelCast.refreshData()
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
			let cellViewModel = SkinProblemTableCellViewModel(withModel: viewModelCast.getItemAtIndexPath(indexPath: indexPath)!, index: indexPath.row)
			cell.configure(withViewModel: cellViewModel)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if viewModelCast.isAddPhotoRow(indexPath: indexPath) {
			// click on add photo
			photoUtils.showChoosePhoto { (success, image) in
				if success && image != nil {
					self.viewModelCast.createSkinProblemAttachment(image: image!)
				}
			}
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return viewModelCast.canEditRow(indexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		viewModelCast.removeAttachment(at: indexPath)
	}
}
