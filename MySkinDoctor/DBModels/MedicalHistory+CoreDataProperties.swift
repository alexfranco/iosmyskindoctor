//
//  MedicalHistory+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension MedicalHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicalHistory> {
        return NSFetchRequest<MedicalHistory>(entityName: "MedicalHistory")
    }

    @NSManaged public var hasHealthProblems: Bool
    @NSManaged public var healthProblemDescription: String?
    @NSManaged public var hasMedication: Bool
    @NSManaged public var hasPastHistoryProblems: Bool
    @NSManaged public var profile: Profile?

}
