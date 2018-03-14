//
//  Doctor+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 14/03/2018.
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
    @NSManaged public var diagnose: Diagnose?
    @NSManaged public var skinProblems: SkinProblems?

}
