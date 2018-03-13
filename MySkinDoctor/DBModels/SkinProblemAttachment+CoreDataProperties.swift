//
//  SkinProblemAttachment+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension SkinProblemAttachment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkinProblemAttachment> {
        return NSFetchRequest<SkinProblemAttachment>(entityName: "SkinProblemAttachment")
    }
	
    @NSManaged public var problemImage: NSObject?
    @NSManaged public var problemDescription: String?
    @NSManaged public var skinProblems: SkinProblems?

}
