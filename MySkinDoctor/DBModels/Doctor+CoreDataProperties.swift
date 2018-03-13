//
//  Doctor+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Doctor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doctor> {
        return NSFetchRequest<Doctor>(entityName: "Doctor")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var profilePicture: NSObject?
    @NSManaged public var qualifications: String?
    @NSManaged public var skinProblems: SkinProblems?
    @NSManaged public var diagnose: Diagnose?

}
