//
//  MySkinProblemsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsViewController: BindingViewController {
	
	@IBOutlet weak var diagnosesSegmentedControl: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("myskinproblems_main_vc_title", comment: "")
		
		configureTableView()
		
		initViewModel(viewModel: MySkinProblemsViewModel())
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
}
	
extension MySkinProblemsViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		var numOfSections: Int = 0
		if  (viewModel as! MySkinProblemsViewModel).getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0
			|| (viewModel as! MySkinProblemsViewModel).getDataSourceCount(section: MySkinProblemsViewModel.diagnosedSection) > 0 {
			tableView.separatorStyle = .singleLine
			numOfSections            = 2
			tableView.backgroundView = nil
		} else {
			let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
			noDataLabel.text          = NSLocalizedString("no_data_available", comment: "")
			noDataLabel.textColor     = UIColor.black
			noDataLabel.textAlignment = .center
			tableView.backgroundView  = noDataLabel
			tableView.separatorStyle  = .none
		}
		
		return numOfSections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (viewModel as! MySkinProblemsViewModel).getDataSourceCount(section: section)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return (viewModel as! MySkinProblemsViewModel).getSectionTitle(section: section)
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		let headerView = (view as! UITableViewHeaderFooterView)
		
		headerView.backgroundView?.backgroundColor = section == MySkinProblemsViewModel.undiagnosedSection ? AppStyle.mySkinUndiagnosedColor : AppStyle.mySkinDiagnosedColor
		headerView.textLabel?.textColor = AppStyle.mySkinTableSectionTextColor
		headerView.textLabel?.font = AppStyle.mySkinTableSectionTextFont
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.mySkinProblemsCellId) as! MySkinProblemsTableViewCell
		
		let viewModel = (self.viewModel as! MySkinProblemsViewModel).getItemAtIndexPath(indexPath: indexPath)
		
		cell.configure(withViewModel: viewModel)
		
		return cell
	}
}
