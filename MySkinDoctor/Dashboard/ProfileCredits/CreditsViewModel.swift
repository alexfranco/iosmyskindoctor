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
	var profile: Profile!
	
	var navigationTitle: String {
		get {
			return "Add Credit"
		}
	}
	
	var getCreditText: String {
		get {
			return profile.credits ?? "0"
		}
	}
	
	override init() {
		super.init()
		
		profile = DataController.createUniqueEntity(type: Profile.self)
		
		isLoading = true
		
		ApiUtils.getCreditsOptions(accessToken: DataController.getAccessToken()) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("get getCreditsOptions")
				let modelSafe = model as! TopupListResponseModel
				self.credits = modelSafe.options
				
				if let stripe = modelSafe.stripe {
					self.profile.stripeKey = stripe.apiKey
					DataController.saveEntity(managedObject: self.profile)
				}
				
				self.onFetchFinished!()
			case .failure(_, let error):
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
