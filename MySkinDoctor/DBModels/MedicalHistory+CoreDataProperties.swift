//
//  MedicalHistory+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension MedicalHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicalHistory> {
        return NSFetchRequest<MedicalHistory>(entityName: "MedicalHistory")
    }

    @NSManaged public var healthProblems: String?
    @NSManaged public var medication: String?
    @NSManaged public var pastHistoryProblems: String?
    @NSManaged public var profile: Profile?
    @NSManaged public var skinProblems: SkinProblems?

}
