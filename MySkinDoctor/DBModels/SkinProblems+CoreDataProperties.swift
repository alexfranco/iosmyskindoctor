//
//  SkinProblems+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension SkinProblems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkinProblems> {
        return NSFetchRequest<SkinProblems>(entityName: "SkinProblems")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var skinProblemDescription: String?
    @NSManaged public var skinProblemId: Int16
    @NSManaged public var attachments: NSSet?
    @NSManaged public var diagnose: Diagnose?
    @NSManaged public var medicalHistory: MedicalHistory?
    @NSManaged public var consultation: NSSet?

}

// MARK: Generated accessors for attachments
extension SkinProblems {

    @objc(addAttachmentsObject:)
    @NSManaged public func addToAttachments(_ value: SkinProblemAttachment)

    @objc(removeAttachmentsObject:)
    @NSManaged public func removeFromAttachments(_ value: SkinProblemAttachment)

    @objc(addAttachments:)
    @NSManaged public func addToAttachments(_ values: NSSet)

    @objc(removeAttachments:)
    @NSManaged public func removeFromAttachments(_ values: NSSet)

}

// MARK: Generated accessors for consultation
extension SkinProblems {

    @objc(addConsultationObject:)
    @NSManaged public func addToConsultation(_ value: Consultation)

    @objc(removeConsultationObject:)
    @NSManaged public func removeFromConsultation(_ value: Consultation)

    @objc(addConsultation:)
    @NSManaged public func addToConsultation(_ values: NSSet)

    @objc(removeConsultation:)
    @NSManaged public func removeFromConsultation(_ values: NSSet)

}
