//
//  FormTextView.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import SZTextView

class FormTextView: SZTextView {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}
	
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		configure()
	}
	
	deinit {
		let nc = NotificationCenter.default
		nc.removeObserver(self)
	}
	
	func configure() {
		let nc = NotificationCenter.default
		nc.addObserver(self, selector: #selector(textViewDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
	}
	
	// MARK: Binding
	
	var textChanged :(String) -> () = { _ in }
	
	func bind(callback :@escaping (String) -> ()) {
		self.textChanged = callback
	}
	
	@objc func textViewDidChange() {
		self.textChanged(text!)		
	}

}
