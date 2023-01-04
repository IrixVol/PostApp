//
//  NSManagedObject+Extension.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    static var className: String {
        String(describing: self)
    }
    
    var className: String {
        String(describing: type(of: self))
    }
}

extension NSManagedObjectContext {
    
    func saveContext() {
        
        guard hasChanges else { return }
        
        do {
            try save()
        } catch {
            rollback()
            assertionFailure(error.localizedDescription)
        }
    }
    
    func executeRequest(_ request: NSPersistentStoreRequest) {
        
        do {
            try execute(request)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
