//
//  CreditsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class CreditsViewController: BindingViewController {
	
	@IBOutlet weak var availableBalanceTitleLabel: UILabel!
	@IBOutlet weak var availableBalanceLabel: UILabel!	
	@IBOutlet weak var tableView: UITableView!
	
	var viewModelCast: CreditsViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initViewModel(viewModel: CreditsViewModel())
		
		configureTableView()
		applyTheme()
		applyLocalization()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		availableBalanceLabel.text = viewModelCast.getCreditText
		navigationController?.title = viewModelCast.navigationTitle
		
		viewModelCast.refreshData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setBackgroundColorWithoutShadowImage(bgColor: AppStyle.defaultNavigationBarColor, titleColor: AppStyle.defaultNavigationBarTitleColor)
		
	}
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as? CreditsViewModel
		
		viewModelCast.onFetchFinished = { [weak self] () in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
	
	// MARK: Helpers
	func applyTheme() {
		availableBalanceTitleLabel.font = AppStyle.availableBalanceTitleFont
		availableBalanceLabel.font = AppStyle.availableBalanceLabelFont
		availableBalanceLabel.textColor = AppStyle.availableBalanceLabelTextColor
	}
	
	func applyLocalization() {
		title = NSLocalizedString("credit_vc_title", comment: "")
		availableBalanceTitleLabel.text = NSLocalizedString("credit_available_balance_title", comment: "")
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Segues.goToCreditCard {
			if let dest = segue.destination as? CreditCardViewController, let creditOption = sender as? CreditOptionsResponseModel {
				dest.initViewModel(viewModel: CreditCardViewModel(creditOption: creditOption))
			}
		}
	}
}

extension CreditsViewController: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: UITableView
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModelCast.getNumberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModelCast.getDataSourceCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.creditCellId) as! CreditTableViewCell
		cell.configure(withViewModel: CreditTableViewModel(model: viewModelCast.getItemAtIndexPath(indexPath: indexPath)!))
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.performSegue(withIdentifier: Segues.goToCreditCard, sender: viewModelCast.getItemAtIndexPath(indexPath: indexPath))
	}
	
}
