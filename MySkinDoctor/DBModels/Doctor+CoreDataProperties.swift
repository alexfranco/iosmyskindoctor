//
//  Doctor+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 06/04/2018.
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
    @NSManaged public var profilePicture: NSObject?
    @NSManaged public var qualifications: String?
    @NSManaged public var doctorId: Int16
    @NSManaged public var profilePictureUrl: String?
    @NSManaged public var consultation: Consultation?
    @NSManaged public var diagnose: Diagnose?
    @NSManaged public var skinProblems: SkinProblems?

}
