//
//  Doctor+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Doctor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doctor> {
        return NSFetchRequest<Doctor>(entityName: "Doctor")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var doctorId: Int16
    @NSManaged public var profilePicture: NSObject?
    @NSManaged public var profilePictureUrl: String?
    @NSManaged public var qualifications: String?
    @NSManaged public var diagnose: NSSet?

}

// MARK: Generated accessors for diagnose
extension Doctor {

    @objc(addDiagnoseObject:)
    @NSManaged public func addToDiagnose(_ value: Diagnose)

    @objc(removeDiagnoseObject:)
    @NSManaged public func removeFromDiagnose(_ value: Diagnose)

    @objc(addDiagnose:)
    @NSManaged public func addToDiagnose(_ values: NSSet)

    @objc(removeDiagnose:)
    @NSManaged public func removeFromDiagnose(_ values: NSSet)

}
