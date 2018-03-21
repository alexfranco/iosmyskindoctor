//
//  MedicalHistory+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 21/03/2018.
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
    @NSManaged public var skinProblems: SkinProblems?
    @NSManaged public var profile: Profile?

}
