//
//  DiagnoseAttachments+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 14/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension DiagnoseAttachments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiagnoseAttachments> {
        return NSFetchRequest<DiagnoseAttachments>(entityName: "DiagnoseAttachments")
    }

    @NSManaged public var filename: String?
    @NSManaged public var icon: NSObject?
    @NSManaged public var localFilepath: String?
    @NSManaged public var url: String?
    @NSManaged public var diagnose: Diagnose?

}
