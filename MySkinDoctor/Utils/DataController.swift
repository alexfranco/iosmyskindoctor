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
	static func disconnectedEntity<T: NSManagedObject>(type: T.Type) -> T {
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
	}
	
	static func createOrUpdate<T: NSManagedObject>(objectIdKey: String, objectValue: Int, type: T.Type) -> T {
		let entityName = String(describing: type)
		let entity = NSEntityDescription.entity(forEntityName: entityName, in:  CoreDataStack.managedObjectContext)
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		request.predicate = NSPredicate(format: "\(objectIdKey) == \(objectValue)")
		
		do {
			let result = try CoreDataStack.managedObjectContext.fetch(request)
			
			if let first = result.first as? T {
				return first
			} else {
				return createNew(type: type)
			}
			
		} catch {
			print("createOrUpdate")
		}
		
		
		return NSManagedObject(entity: entity!, insertInto: CoreDataStack.managedObjectContext) as! T
	}
	
	static func createUniqueEntity<T: NSManagedObject>(type: T.Type) -> T {
		let result = fetchAll(type: type)
			
		if let resultSafe = result, let first = resultSafe.first {
			return first
		} else {
			return createNew(type: type)
		}				
	}
	
	static func fetchAll<T: NSManagedObject>(type: T.Type, sortByKey: String = "") -> [T]? {
		let entityName = String(describing: type)
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		
		if !sortByKey.isEmpty {
			request.sortDescriptors = [NSSortDescriptor(key: sortByKey, ascending: false)]
		}
		
		do {
			let result = try CoreDataStack.managedObjectContext.fetch(request)
			return result as? [T]
			
		} catch {
			print("fetchAll Failed")
		}
		
		return nil
	}
	
	static func fetch<T: NSManagedObject>(type: T.Type) -> T? {
		let entityName = String(describing: type)
		
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		
		do {
			let result = try CoreDataStack.managedObjectContext.fetch(request)
			
			if let first = result.first as? T {
				return first
			}		
			
		} catch {
			print("fetch Failed")
		}
		
		return nil
	}
	
	static func getManagedObject(managedObjectId: NSManagedObjectID) -> NSManagedObject {
		return  CoreDataStack.managedObjectContext.object(with: managedObjectId)
	}
	
	static func deleteManagedObject(managedObject: NSManagedObject) {
		CoreDataStack.managedObjectContext.delete(managedObject)
		
		do {
			try CoreDataStack.managedObjectContext.save()
		} catch let error {
			print("saveEntity error \(error.localizedDescription)")
		}
	}
	
	static func saveEntity(managedObject: NSManagedObject) {
		do {
			try managedObject.managedObjectContext?.save()
		} catch let error {
			print("saveEntity error \(error.localizedDescription)")
		}
	}
	
	static func deleteEntity<T: NSManagedObject>(type: T.Type) {
		let moc = CoreDataStack.managedObjectContext
		let entityName = String(describing: type)
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		
		if let results = try? moc.fetch(fetchRequest) {
			for object in results {
				moc.delete(object as! NSManagedObject)
			}
			CoreDataStack.saveContext()
		}		
	}
	
	static func getAccessToken() -> String {
		return DataController.createUniqueEntity(type: Profile.self).key ?? ""
	}
	
	static func login(email: String, key: String) {
		let defaults = UserDefaults.standard
		defaults.set(true, forKey: UserDefaultConsts.isUserLoggedIn)
		defaults.set(true, forKey: UserDefaultConsts.isFirstTime)
	
		deleteEntity(type: Profile.self)
		
		let profile = createUniqueEntity(type: Profile.self)
		profile.key = key
		profile.email = email
		
		saveEntity(managedObject: profile)
	}
	
	static func register(email: String) {
		let defaults = UserDefaults.standard
		defaults.set(email, forKey: UserDefaultConsts.email)
		defaults.synchronize()
	}
	
	static func logout() {
		ApiUtils.logoutUser(accessToken: DataController.getAccessToken()) { (result) in
			self.clearDataAfterLoggedOut()
		}
	}
	
	private static func clearDataAfterLoggedOut() {
		CoreDataStack.deleteAllObjects { () in
			let defaults = UserDefaults.standard
			defaults.set(false, forKey: UserDefaultConsts.isUserLoggedIn)
			defaults.set(false, forKey: UserDefaultConsts.isFirstTime)
			defaults.removeObject(forKey: UserDefaultConsts.email)
			
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			appDelegate.updateRootVC()
		}
	}
}
