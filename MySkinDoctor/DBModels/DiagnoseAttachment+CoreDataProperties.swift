//
//  DiagnoseAttachment+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 03/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension DiagnoseAttachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiagnoseAttachment> {
        return NSFetchRequest<DiagnoseAttachment>(entityName: "DiagnoseAttachment")
    }

    @NSManaged public var diagnoseAttachmentName: String?
    @NSManaged public var icon: NSObject?
    @NSManaged public var url: String?
    @NSManaged public var diagnosemAttachmentId: Int16
    @NSManaged public var diagnose: Diagnose?

}
