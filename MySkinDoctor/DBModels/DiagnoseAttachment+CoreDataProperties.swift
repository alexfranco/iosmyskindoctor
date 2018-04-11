//
//  DiagnoseAttachment+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 11/04/2018.
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
    @NSManaged public var diagnosemAttachmentId: Int16
    @NSManaged public var icon: NSObject?
    @NSManaged public var url: String?
    @NSManaged public var diagnose: NSSet?

}

// MARK: Generated accessors for diagnose
extension DiagnoseAttachment {

    @objc(addDiagnoseObject:)
    @NSManaged public func addToDiagnose(_ value: Diagnose)

    @objc(removeDiagnoseObject:)
    @NSManaged public func removeFromDiagnose(_ value: Diagnose)

    @objc(addDiagnose:)
    @NSManaged public func addToDiagnose(_ values: NSSet)

    @objc(removeDiagnose:)
    @NSManaged public func removeFromDiagnose(_ values: NSSet)

}
