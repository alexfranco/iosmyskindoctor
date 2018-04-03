//
//  Diagnose+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 03/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Diagnose {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diagnose> {
        return NSFetchRequest<Diagnose>(entityName: "Diagnose")
    }

    @NSManaged public var comments: String?
    @NSManaged public var diagnoseDate: NSDate?
    @NSManaged public var diagnoseStatus: Int16
    @NSManaged public var patientInformation: String?
    @NSManaged public var summary: String?
    @NSManaged public var treatment: String?
    @NSManaged public var attachments: NSSet?
    @NSManaged public var doctor: Doctor?
    @NSManaged public var doctorNotes: NSSet?
    @NSManaged public var skinProblems: SkinProblems?

}

// MARK: Generated accessors for attachments
extension Diagnose {

    @objc(addAttachmentsObject:)
    @NSManaged public func addToAttachments(_ value: DiagnoseAttachment)

    @objc(removeAttachmentsObject:)
    @NSManaged public func removeFromAttachments(_ value: DiagnoseAttachment)

    @objc(addAttachments:)
    @NSManaged public func addToAttachments(_ values: NSSet)

    @objc(removeAttachments:)
    @NSManaged public func removeFromAttachments(_ values: NSSet)

}

// MARK: Generated accessors for doctorNotes
extension Diagnose {

    @objc(addDoctorNotesObject:)
    @NSManaged public func addToDoctorNotes(_ value: DoctorNotes)

    @objc(removeDoctorNotesObject:)
    @NSManaged public func removeFromDoctorNotes(_ value: DoctorNotes)

    @objc(addDoctorNotes:)
    @NSManaged public func addToDoctorNotes(_ values: NSSet)

    @objc(removeDoctorNotes:)
    @NSManaged public func removeFromDoctorNotes(_ values: NSSet)

}
