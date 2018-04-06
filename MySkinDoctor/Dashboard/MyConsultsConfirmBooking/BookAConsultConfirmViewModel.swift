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
	
	var appointment: AppointmentsResponseModel!
	var model: SkinProblems!
	var consultationModel: Consultation?

	required init(skinProblemsManagedObjectId: NSManagedObjectID, appointment: AppointmentsResponseModel) {
		super.init()
		self.model = DataController.getManagedObject(managedObjectId: skinProblemsManagedObjectId) as? SkinProblems
		self.appointment = appointment
	}
	
	var dateLabelText: String {
		get {
			return appointment.start!.ordinalMonthAndYear()
		}
	}
	
	var timeLabelText: String {
		get {
			let df = DateFormatter()
			df.dateFormat = "HH:mm a"
			df.amSymbol = "AM"
			df.pmSymbol = "PM"
			return df.string(from: appointment.start!)
		}
	}
	
	override func saveModel() {
		super.saveModel()
		
		self.isLoading = true
		ApiUtils.createAppointment(accessToken: DataController.getAccessToken(), skinProblemsId: Int(model.skinProblemId), startDate: appointment.start!, endDate: appointment.end!) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("createAppointment")
				self.consultationModel = Consultation.parseAndSaveResponse(consultationResponseModel: (model as! ConsultationResponseModel).event!)!
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
}
