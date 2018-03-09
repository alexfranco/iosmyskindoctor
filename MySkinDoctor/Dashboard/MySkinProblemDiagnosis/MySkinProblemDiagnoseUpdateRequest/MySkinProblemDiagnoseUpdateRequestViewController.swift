//
//  MySkinProblemDiagnoseUpdateRequestViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 09/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemDiagnoseUpdateRequestViewController: BaseMySkinProblemDiagnosisViewController {
	
	@IBOutlet weak var notesTitleLabel: TitleLabel!
	@IBOutlet weak var tableView: UITableView!
	
	private var viewModelCast: MySkinProblemDiagnoseUpdateRequestViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MySkinProblemDiagnoseUpdateRequestViewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
	}
	
	override func applyTheme() {
		super.applyTheme()
		
		notesTitleLabel.textColor = AppStyle.diagnoseTitleColor
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.allowsSelection = false
		tableView.separatorStyle = .none
	}
}

extension MySkinProblemDiagnoseUpdateRequestViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		if viewModelCast.getDataSourceCount() == 0 {
			let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
			noDataLabel.text          = "No notes available"
			noDataLabel.textColor     = UIColor.black
			noDataLabel.textAlignment = .center
			tableView.backgroundView  = noDataLabel
			tableView.separatorStyle  = .none
			
			return 0
		} else {
			tableView.separatorStyle = .singleLine
			tableView.backgroundView = nil
			
			return 1
		}
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModelCast.getDataSourceCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.updateRequestCellId) as! MySkinProblemDiagnoseUpdateRequestTableViewCell
		
		let viewModel = viewModelCast.getItemAtIndexPath(indexPath: indexPath)
		cell.configure(withViewModel: MySkinProblemDiagnoseUpdateRequestTableViewModel(withModel: viewModel))
		
		return cell
	}
}
