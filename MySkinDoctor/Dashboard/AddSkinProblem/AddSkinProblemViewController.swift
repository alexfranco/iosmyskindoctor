//
//  AddSkinProblemViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinProblemViewController: BindingViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var descriptionLabel: GrayLabel!
	
	@IBOutlet weak var descriptionTextView: FormTextView! {
		didSet {
			descriptionTextView.bind { (self.viewModel as! AddSkinProblemViewModel).skinProblemDescription = $0 }
		}
	}
	
	var photoUtils: PhotoUtils!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("addskinproblems_main_vc_title", comment: "")
		
		descriptionTextView.placeholder = "Please enter.... TODO"
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		configureTableView()
		photoUtils = PhotoUtils.init(inViewController: self)
		
		initViewModel(viewModel: AddSkinProblemViewModel())
	}
	
	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		guard let viewModelSafe = viewModel as? AddSkinProblemViewModel else { return }
		
		viewModelSafe.refresh = { [weak self] () in
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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToSkinProblemPhotoInformationViewController {
			if let dest = segue.destination as? SkinProblemPhotoInformationViewController, let image = sender as? UIImage {
				let skinProblem = SkinProblemModel(problemImage: image) // create new skin problem with the image attached
				dest.initViewModel(viewModel: SkinProblemPhotoInformationViewModel(model:  skinProblem))
			}
		}
	}
}

extension AddSkinProblemViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return (viewModel as! AddSkinProblemViewModel).getNumberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (viewModel as! AddSkinProblemViewModel).getDataSourceCount(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let addSkinProblemViewModel = (viewModel as! AddSkinProblemViewModel)
		
		if addSkinProblemViewModel.getDataSourceCount(section: indexPath.section) == indexPath.row + 1 {
			return tableView.dequeueReusableCell(withIdentifier: CellId.addPhotoTableViewCellId) as! AddPhotoTableViewCell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: CellId.skinProblemTableViewCellId) as! SkinProblemTableViewCell
			let cellViewModel = SkinProblemTableCellViewModel(withModel: addSkinProblemViewModel.getItemAtIndexPath(indexPath: indexPath))
			cell.configure(withViewModel: cellViewModel)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let addSkinProblemViewModel = (viewModel as! AddSkinProblemViewModel)
		
		if addSkinProblemViewModel.getDataSourceCount(section: indexPath.section) == indexPath.row + 1 {
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

