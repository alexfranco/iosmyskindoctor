//
//  BookAConsultConfirmViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 07/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

class BookAConsultConfirmViewModel: BaseViewModel {
	
	var selectedDate: Date!
	var modelId: NSManagedObjectID?

	required init(selectedDate: Date) {
		super.init()
		self.selectedDate = selectedDate
	}
	
	var dateLabelText: String {
		get {
			return selectedDate.ordinalMonthAndYear()
		}
	}
	
	var timeLabelText: String {
		get {
			let df = DateFormatter()
			df.dateFormat = "HH:ss a"
			df.amSymbol = "AM"
			df.pmSymbol = "PM"
			return df.string(from: selectedDate)
		}
	}
	
	override func saveModel() {
		super.saveModel()
		
		let consultation = DataController.createNew(type: Consultation.self)
		consultation.appointmentDate = selectedDate! as NSDate
		
		let doctor = DataController.createNew(type: Doctor.self)
		doctor.displayName = "Dr Jane"
		doctor.qualifications = "A lot of qualifications"
		
		DataController.saveEntity(managedObject: doctor)
		consultation.doctor = doctor
		DataController.saveEntity(managedObject: consultation)
		
		modelId = consultation.objectID
					
		goNextSegue!()
	}
	
}
