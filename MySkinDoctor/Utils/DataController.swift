//
//  DataController.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataController {
	
	static func createNew<T: NSManagedObject>(type: T.Type) -> T? {
		let entityName = String(describing: type)
		let entity = NSEntityDescription.entity(forEntityName: entityName, in:  CoreDataStack.managedObjectContext)
		return NSManagedObject(entity: entity!, insertInto: CoreDataStack.managedObjectContext) as? T
	}
	
	static func createUniqueObject<T: NSManagedObject>(type: T.Type) -> T? {
		let result = fetchAll(type: type)
			
		if let resultSafe = result, let first = resultSafe.first {
			return first
		} else {
			return createNew(type: type)
		}				
	}
	
	static func fetchAll<T: NSManagedObject>(type: T.Type) -> [T]? {
		let entityName = String(describing: type)
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		
		do {
			let result = try CoreDataStack.managedObjectContext.fetch(request)
			return result as? [T]
			
		} catch {
			print("fetchAll Failed")
		}
		
		return nil
	}
}
