//
//  DoctorNotes+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 14/03/2018.
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
