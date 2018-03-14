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
	
	// Creates a temporal entity
	static private func disconnectedEntity<T: NSManagedObject>(type: T.Type) -> T {
		let entityName = String(describing: type)
		let entity = NSEntityDescription.entity(forEntityName: entityName, in:  CoreDataStack.managedObjectContext)
		return NSManagedObject(entity: entity!, insertInto: nil) as! T
	}
	
	// Inserts the entitty into our currenct to context
	static private func addEntityToCurrentContext(managedObject: NSManagedObject) {
		CoreDataStack.managedObjectContext.insert(managedObject)
	}
	
	static func createNew<T: NSManagedObject>(type: T.Type) -> T {
		let entityName = String(describing: type)
		let entity = NSEntityDescription.entity(forEntityName: entityName, in:  CoreDataStack.managedObjectContext)
		return NSManagedObject(entity: entity!, insertInto: CoreDataStack.managedObjectContext) as! T
//		return disconnectedEntity(type: type)
	}
	
	static func createUniqueEntity<T: NSManagedObject>(type: T.Type) -> T {
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
//	
//	static func fetch<T: NSManagedObject>(type: T.Type, managedObjectId: NSManagedObjectID) -> T? {
//		let entityName = String(describing: type)
//		
//		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//		request.predicate = NSPredicate(format: "SELF = %@", managedObjectId)
//		
//		do {
//			let result = try CoreDataStack.managedObjectContext.fetch(request)
//			return result as? T
//			
//		} catch {
//			print("fetchAll Failed")
//		}
//		
//		return nil
//	}
	
	
	static func getManagedObject(managedObjectId: NSManagedObjectID) -> NSManagedObject {
		return  CoreDataStack.managedObjectContext.object(with: managedObjectId)
	}
	
	static func saveEntity(managedObject: NSManagedObject) {
		do {
			if managedObject.managedObjectContext == nil {
				addEntityToCurrentContext(managedObject: managedObject)
			}
			try CoreDataStack.managedObjectContext.save()
		} catch let error {
			print("saveEntity error \(error.localizedDescription)")
		}
	}
}
