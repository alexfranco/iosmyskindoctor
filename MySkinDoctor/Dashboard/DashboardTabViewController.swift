//
//  DashboardTabViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class DashboardTabViewController: UITabBarController {
	
	let mySkinTab = 0
	let consultTab = 1
	let myProfileTab = 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tabBar.items?[mySkinTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.defaultTabBarColor], for: .normal)
		self.tabBar.items?[consultTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.defaultTabBarColor], for: .normal)
		self.tabBar.items?[myProfileTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.defaultTabBarColor], for: .normal)
		
		self.tabBar.items?[mySkinTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.mySkinTabBarTitleColor], for: .selected)
		self.tabBar.items?[consultTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.consultTabBarTitleColor], for: .selected)
		self.tabBar.items?[myProfileTab].setTitleTextAttributes([NSAttributedStringKey.foregroundColor: AppStyle.profileBarTitleColor], for: .selected)
		
		self.tabBar.items?[mySkinTab].image = UIImage(named: "skinProblemsInactive")?.withRenderingMode(.alwaysOriginal)
		self.tabBar.items?[consultTab].image = UIImage(named: "consultsInactive")?.withRenderingMode(.alwaysOriginal)
		self.tabBar.items?[myProfileTab].image = UIImage(named: "profileInactive")?.withRenderingMode(.alwaysOriginal)

		self.tabBar.items?[mySkinTab].selectedImage = UIImage(named: "skinProblemsActive")?.withRenderingMode(.alwaysOriginal)
		self.tabBar.items?[consultTab].selectedImage = UIImage(named: "consultsActive")?.withRenderingMode(.alwaysOriginal)
		self.tabBar.items?[myProfileTab].selectedImage = UIImage(named: "profileActive")?.withRenderingMode(.alwaysOriginal)		
	}
	
	
}

