//
//  Consultation+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Consultation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Consultation> {
        return NSFetchRequest<Consultation>(entityName: "Consultation")
    }

    @NSManaged public var appointmentDate: NSDate?
    @NSManaged public var appointmentId: Int16
    @NSManaged public var isCancelled: Int16
    @NSManaged public var duration: Int16
    @NSManaged public var skinProblems: SkinProblems?

}
