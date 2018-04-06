//
//  CreditCardViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import Stripe

class CreditCardViewModel: BaseViewModel {
	
	var profile: Profile!
	var creditOption: CreditOptionsResponseModel!
	var onPaymentSuccess: ((_ sumamry: String)->())?
	
	var creditText: String {
		if let credits = creditOption.credits {
			return String(format: NSLocalizedString("add_credit_credit_value", comment: "Credit amount"), arguments: [credits])
		} else {
			return ""
		}
	}
	
	var amountText: String {
		if let amount = creditOption.amount {
			return String(format: NSLocalizedString("add_credit_buy_value", comment: "Credit amount"), arguments: [amount, "GBP"])
		} else {
			return ""
		}
	}
	
	required init(creditOption: CreditOptionsResponseModel) {
		self.profile = DataController.createUniqueEntity(type: Profile.self)
		self.creditOption = creditOption
	}
	
	func pay(params: STPCardParams) {
		isLoading = true
		
		guard let stripKey = self.profile.stripeKey else {
			print("Error", "Stripe key not provided")
			return
		}
		
		Stripe.setDefaultPublishableKey(stripKey)
		STPAPIClient.shared().createToken(withCard: params) { (token, error) -> Void in
			
			if error != nil  {
				self.isLoading = false
				self.showAlert!("Error", error.debugDescription)
			} else if let token = token {
				ApiUtils.payWithCreditCard(accessToken: DataController.getAccessToken(), stripeToken: token.tokenId, optionId: self.creditOption.id!, amount: self.creditOption.amount!, credits: self.creditOption.credits!, completionHandler: { (result) in
					
					self.isLoading = false
					
					switch result {
					case .success(let model):
						print("payWithCreditCard")
						if let modelSafe = model as? CreditCardResponseModel, let summary = modelSafe.summary {
							self.onPaymentSuccess!(summary)
						} else {
							self.onPaymentSuccess!("credits added to account")
						}
					case .failure(let model, let error):
						print("error")
						self.showResponseErrorAlert!(model as? BaseResponseModel, error)
					}
					
				})
			} else {
				self.isLoading = false
				self.showAlert!("Error", "Token null")
			}
		}
	}
	
}
