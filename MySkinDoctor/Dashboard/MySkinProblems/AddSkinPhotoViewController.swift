//
//  AddSkinPhotoViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinPhotoViewController: BindingViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var descriptionLabel: GrayLabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("addskinproblems_main_vc_title", comment: "")
		
		configureTableView()
		
		initViewModel(viewModel: MySkinProblemsViewModel())
	}
	
	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		guard let viewModelSafe = viewModel as? AddSkinPhotoViewModel else { return }
		
//		viewModelSafe.refresh = { [weak self] () in
//			DispatchQueue.main.async {
//				self?.tableView.reloadData()
//				self?.tableView.refreshControl?.endRefreshing()
//			}
//		}
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
}

extension AddSkinPhotoViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.mySkinProblemsCellId) as! AddSkinProblemTableViewCell
		
//		let viewModel = (self.viewModel as! AddSkinPhotoViewModel).getItemAtIndexPath(indexPath: indexPath)
		
//		cell.configure(withViewModel: viewModel)
		
		return cell
	}
}

