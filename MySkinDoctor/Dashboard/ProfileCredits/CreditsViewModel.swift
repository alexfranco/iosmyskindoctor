//
//  CreditsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class CreditsViewModel: BaseViewModel {
	
	var credits: [CreditOptionsResponseModel] = []
	
	var navigationTitle: String {
		get {
			return "Add Credit"
		}
	}
	
	var getCreditText: String {
		return "£ 1"
	}
	
	override init() {
		super.init()
		
		isLoading = true
		
		ApiUtils.getCreditsOptions(accessToken: DataController.getAccessToken()) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("get getCreditsOptions")
				self.credits = model as! [CreditOptionsResponseModel]
				
			case .failure(let model, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}
	
	func getDataSourceCount() -> Int {
		return credits.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> CreditOptionsResponseModel? {
		return allCreditsSorted()[indexPath.row]
	}

	func getNumberOfSections() -> Int {
		return 1
	}
	
	private func allCreditsSorted() -> [CreditOptionsResponseModel] {
		return credits.sorted(by: { $0.id! < $1.id!})
	}
}
