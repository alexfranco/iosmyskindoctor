//
//  MyConsultsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyConsultsViewController: BindingViewController {
	
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	
	var viewModelCast: MyConsultsViewModel!
	var refreshControl: UIRefreshControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("myconsults_main_vc_title", comment: "")

		segmentedControl.setTitle(NSLocalizedString("myconsults_segmented_all", comment: ""), forSegmentAt: MyConsultsViewModel.ConsultSegmentedEnum.all.rawValue)
		segmentedControl.setTitle(NSLocalizedString("myconsults_segmented_upcoming", comment: ""), forSegmentAt: MyConsultsViewModel.ConsultSegmentedEnum.upcoming.rawValue)
		segmentedControl.setTitle(NSLocalizedString("myconsults_segmented_history", comment: ""), forSegmentAt: MyConsultsViewModel.ConsultSegmentedEnum.history.rawValue)

		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
		configureTableView()
		
		initViewModel(viewModel: MyConsultsViewModel())
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModelCast.refreshData()
	}
	
	// MARK: Helpers
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MyConsultsViewModel
		
		viewModelCast.refresh = { [weak self] () in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
				self?.refreshControl?.endRefreshing()
			}
		}
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
		
		refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)),for: UIControlEvents.valueChanged)
		
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
	}
	
	@objc func handleRefresh(refreshControl: UIRefreshControl) {
		viewModelCast.refreshData()
	}
	
	// MARK: IBAction
	
	@IBAction func onSegmentedControlValueChanged(_ sender: Any) {
		viewModelCast.selectedSegmented = MyConsultsViewModel.ConsultSegmentedEnum(rawValue: self.segmentedControl.selectedSegmentIndex)!
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToMyConsultDetails {
			if let nc = segue.destination as? UINavigationController, let dest = nc.viewControllers.first as? MyConsultDetailsViewController, let objectID = sender as? NSManagedObjectID {
				dest.initViewModel(viewModel: MyConsultDetailsViewModel(modelId: objectID))
			}
		}
	}
}

extension MyConsultsViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		let numOfSections = viewModelCast.getNumberOfSections()
		
		if numOfSections == 0 {
			tableView.addNoDataLabel(labelText: NSLocalizedString("myconsults_no_data", comment: ""))
		} else {
			tableView.removeNoDataLabel()
		}
		
		return numOfSections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModelCast.getDataSourceCount(section: section)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return viewModelCast.getSectionTitle(section: section)
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		let headerView = (view as! UITableViewHeaderFooterView)
		
		headerView.backgroundView?.backgroundColor = viewModelCast.getHeaderBackgroundColor(section: section)
		headerView.textLabel?.textColor = viewModelCast.getHeaderTextColor(section: section)
		headerView.textLabel?.font = AppStyle.consultTableSectionTextFont
	}
		
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.myConsultTableViewCellId) as! MyConsultTableViewCell
		
		let viewModel = viewModelCast.getItemAtIndexPath(indexPath: indexPath)
		cell.configure(withViewModel: MyConsultTableViewCellViewModel(model: viewModel))
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let viewModel = viewModelCast.getItemAtIndexPath(indexPath: indexPath)
		performSegue(withIdentifier: Segues.goToMyConsultDetails, sender: viewModel.objectID)
	}

}
