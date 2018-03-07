//
//  ProgressBarViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 15/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class ProgressBarViewController: UIViewController {
	
	var hud: MBProgressHUD?
	
	// MARK: MBProgressHUD
	
	func showSpinner(_ text: String?) {
		let view = self.view.window == nil ? self.view : self.view.window
		
		// Show spinner
		self.hud = MBProgressHUD.showAdded(to: view!, animated:true)
		if let spinner = self.hud {
			if let textSafe = text {
				spinner.label.text = textSafe
			}
			DispatchQueue.main.async(execute: {
				spinner.show(animated: true)
			})
		}
	}
	
	func updateSpinner(_ text: String?) {
		if let spinner = self.hud {
			if let textSafe = text {
				spinner.label.text = textSafe
			}
		}
	}
	
	func hideSpinner() {
		// Hide spinner
		DispatchQueue.main.async(execute: {
			if let spinner = self.hud {
				spinner.hide(animated: true)
			}
		})
	}
}

class BaseViewController: UIViewController {
	override func viewWillDisappear(_ animated: Bool) {
		let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backItem
	}
}
