//
//  SkinProblems.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 01/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemsModel: NSObject {
	
	var date: Date
	var isSubmitted: Bool = false
	var skinProblemDescription: String = ""
	var problems: [SkinProblemModel] = []
	var medicalHiostry = MedicalHistoryModel()
	var diagnose: Diagnose!
	
	var isDiagnosed: Bool {
		return diagnose.diagnoseStatus == .noFutherCommunicationRequired ||  diagnose.diagnoseStatus == .bookConsultationRequest
	}
	
	override init() {
		date = Date()
		diagnose = Diagnose()
		super.init()
	}
	
	convenience init(date: Date? = Date(), diagnoseStatus: Diagnose.DiagnoseStatus = .none, skinProblemDescription: String = "") {
		self.init()
		
		self.date = date!
		self.diagnose = Diagnose()
		self.diagnose.diagnoseStatus = diagnoseStatus
		self.skinProblemDescription = skinProblemDescription
	}
}

class Diagnose: NSObject {
	enum DiagnoseStatus: Int, CustomStringConvertible {
		case none
		case pending
		case noFutherCommunicationRequired
		case bookConsultationRequest
		
		var index: Int {
			return rawValue
		}
		
		var description: String {
			switch self {
			case .none:
				return "None"
			case .pending:
				return "Pending"
			case .bookConsultationRequest:
				return "Consultation Request"
			case .noFutherCommunicationRequired:
				return "Futher comunication Required"
			}
		}
	}
	
	var diagnoseDate: Date?
	var diagnosedBy: Doctor?
	var diagnoseStatus: DiagnoseStatus = DiagnoseStatus.none
	var summary: String?
	var treatment: String?
	var patientInformation: String?
	var comments: String?
	var attachments = [Attachments]()
	var doctorNotes = [DoctorNote]()
}

class DoctorNote: NSObject {
	var date: Date
	var note: String
	
	required init(date: Date!, note: String!) {
		self.date = date
		self.note = note
		super.init()
	}
}

class Doctor: NSObject {
	var firstName: String?
	var lastName: String?
	var profileImage: UIImage?
	var qualifications: String?
	
	required init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
		super.init()
	}
}

class Attachments: NSObject {
	var filename: String?
	var icon: UIImageView?
	var localFilePath: String?
	var url: String
	
	required init(url: String) {
		self.url = url
		super.init()
	}
}
