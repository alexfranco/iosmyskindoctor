//
//  CreditCardViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import Stripe
import UIKit

class CreditCardViewController: BindingViewController, STPPaymentCardTextFieldDelegate {
	
	@IBOutlet weak var creditLabel: UILabel!
	@IBOutlet weak var currencyLabel: UILabel!
	@IBOutlet weak var paymentView: UIView!
	@IBOutlet weak var payButton: UIButton!
	
	var viewModelCast: CreditCardViewModel!
	var creditResponseModel: CreditOptionsResponseModel!
	let paymentTextField = STPPaymentCardTextField()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurePayment()
		
		creditLabel.text = viewModelCast.creditText
		currencyLabel.text = viewModelCast.amountText
	}
	
	// MARK: STPPaymentCardTextFieldDelegate
	
	func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
		// Toggle navigation
		payButton.isEnabled = textField.isValid
	}
	
	@IBAction func onClickPayButton(_ sender: AnyObject) {
		viewModelCast.pay(params: paymentTextField.cardParams)
	}
	
	// MARK: Helpers
	func configurePayment() {
		paymentTextField.delegate = self
		paymentView.addSubview(paymentTextField)
		
		paymentTextField.translatesAutoresizingMaskIntoConstraints = false
		paymentView.translatesAutoresizingMaskIntoConstraints = false
		paymentView.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: paymentView, attribute: .leading, multiplier: 1.0, constant: 16))
		paymentView.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: paymentView, attribute: .trailing, multiplier: 1.0, constant: -16))
		paymentView.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: paymentView, attribute: .top, multiplier: 1.0, constant: 0))
		paymentView.addConstraint(NSLayoutConstraint(item: paymentTextField, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: paymentView, attribute: .bottom, multiplier: 1.0, constant: 0))
	}
	
	func applyTheme() {
	}
	
	func applyLocalization() {
		title = NSLocalizedString("credit_card_vc_title", comment: "")
		payButton.setTitle(NSLocalizedString("pay", comment: ""), for: .normal) 
	}
}

