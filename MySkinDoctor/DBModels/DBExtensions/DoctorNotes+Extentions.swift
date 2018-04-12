
//
//  DoctorNotes.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 12/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension DoctorNotes {
	
	static func parseAndSave(noteResponseModel: NoteResponseModel) -> DoctorNotes {
		let doctorNotes = DataController.createOrUpdate(objectIdKey: "noteId", objectValue: noteResponseModel.noteId, type: DoctorNotes.self)
		doctorNotes.noteId = Int16(noteResponseModel.noteId)
		doctorNotes.note = noteResponseModel.note
		
		if let date = noteResponseModel.dateCreated as NSDate? {
			doctorNotes.date = date
		}
		
		DataController.saveEntity(managedObject: doctorNotes)
		
		return doctorNotes
	}
}
