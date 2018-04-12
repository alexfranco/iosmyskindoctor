//
//  DoctorNotes+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 12/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension DoctorNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoctorNotes> {
        return NSFetchRequest<DoctorNotes>(entityName: "DoctorNotes")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var note: String?
    @NSManaged public var noteId: Int16
    @NSManaged public var diagnose: NSSet?

}

// MARK: Generated accessors for diagnose
extension DoctorNotes {

    @objc(addDiagnoseObject:)
    @NSManaged public func addToDiagnose(_ value: Diagnose)

    @objc(removeDiagnoseObject:)
    @NSManaged public func removeFromDiagnose(_ value: Diagnose)

    @objc(addDiagnose:)
    @NSManaged public func addToDiagnose(_ values: NSSet)

    @objc(removeDiagnose:)
    @NSManaged public func removeFromDiagnose(_ values: NSSet)

}
