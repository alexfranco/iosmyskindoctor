//
//  SkinProblemAttachment+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension SkinProblemAttachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkinProblemAttachment> {
        return NSFetchRequest<SkinProblemAttachment>(entityName: "SkinProblemAttachment")
    }

    @NSManaged public var attachmentType: Int16
    @NSManaged public var filename: String?
    @NSManaged public var locationType: String?
    @NSManaged public var problemDescription: String?
    @NSManaged public var problemImage: NSObject?
    @NSManaged public var skinProblemAttachmentId: Int16
    @NSManaged public var url: String?
    @NSManaged public var skinProblems: SkinProblems?

}
