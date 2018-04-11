//
//  MySkinProblemDiagnosisViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 08/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MySkinProblemDiagnosisViewModel: BaseMySkinProblemDiagnosisViewModel {
	
	var diagnosis: String {
		return self.model.diagnose!.summary ?? "-"
	}
	
	var treatment: String {
		return self.model.diagnose!.treatment ?? "-"
	}
	
	var patientInformation: String {
		return self.model.diagnose!.patientInformation ?? "-"
	}
	
	var comments: String {
		return self.model.diagnose!.comments ?? "-"
	}
}

extension MySkinProblemDiagnosisViewModel {
	
	func getDataSourceCount() -> Int {
		return allAttachmentsSorted().count
	}
	
	func getAttachmentAtIndex(index: Int) -> DiagnoseAttachment? {
		return allAttachmentsSorted()[index]
	}
	
	func getAttachmentNameAtIndex(index: Int) -> String {
		return getAttachmentAtIndex(index: index)?.diagnoseAttachmentName ?? "-"
	}
	
	func getAttachmentUrlAtIndex(index: Int) -> String? {
		return getAttachmentAtIndex(index: index)?.url
	}
	
	private func allAttachmentsSorted() -> [DiagnoseAttachment] {
		guard let model = self.model, let diagnose = model.diagnose, let attachments = diagnose.attachments?.allObjects as? [DiagnoseAttachment] else { return []}
		return attachments.sorted(by: { $0.diagnosemAttachmentId < $1.diagnosemAttachmentId})
	}
	
	func openAttachment(index: Int) {
		if let urlString = getAttachmentUrlAtIndex(index: index), let url = URL(string: urlString), UIApplication.shared.openURL(url) {
			print("default browser was successfully opened")
		} else {
			showAlert!("Error", "Error opening the attachment file")
		}
	}
	
}
