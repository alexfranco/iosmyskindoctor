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
	@IBOutlet weak var descriptionTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("addskinproblems_main_vc_title", comment: "")
		
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		configureTableView()
		
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
			cell.configure(withViewModel: addSkinProblemViewModel.getItemAtIndexPath(indexPath: indexPath))
			return cell
		}
	}
}

