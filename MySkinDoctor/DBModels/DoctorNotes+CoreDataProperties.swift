//
//  DoctorNotes+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
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
    @NSManaged public var diagnose: Diagnose?

}
