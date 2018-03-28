//
//  Profile+CoreDataProperties.swift
//  MySkinDoctor
//
//  Created by Alex on 23/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var addressLine1: String?
    @NSManaged public var addressLine2: String?
    @NSManaged public var dob: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var accessCode: String?
    @NSManaged public var gpAddressLine: String?
    @NSManaged public var gpName: String?
    @NSManaged public var gpPostcode: String?
    @NSManaged public var isNHS: Bool
    @NSManaged public var isPermisionEnabled: Bool
    @NSManaged public var key: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phone: String?
    @NSManaged public var postcode: String?
    @NSManaged public var profileImage: NSObject?
    @NSManaged public var town: String?
    @NSManaged public var medicalHistory: MedicalHistory?

}
