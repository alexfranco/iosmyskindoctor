//
//  MySkinProblemsViewController.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var diagnosesSegmentedControl: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	
	var items = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = NSLocalizedString("My Skin Problems", comment: "")
		
		items = ["Hola", "Adios"]
		
		configureTableView()
	}
	
	// MARK: UITableView
	
	func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.estimatedRowHeight = 80.0
		tableView.rowHeight = UITableViewAutomaticDimension
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		var numOfSections: Int = 0
		if  items.count > 0 {
			tableView.separatorStyle = .singleLine
			numOfSections            = 1
			tableView.backgroundView = nil
		} else {
			let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
			noDataLabel.text          = "No data available"
			noDataLabel.textColor     = UIColor.black
			noDataLabel.textAlignment = .center
			tableView.backgroundView  = noDataLabel
			tableView.separatorStyle  = .none
		}
		
		return numOfSections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellId.mySKinProblemsCellId) as! UITableViewCell
		
		cell.textLabel?.text = items[indexPath.row]
		
		return cell
	}

}
