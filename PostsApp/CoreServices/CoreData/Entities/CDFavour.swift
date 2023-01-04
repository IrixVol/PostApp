//
//  CDFavour.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

final class CDFavour: NSManagedObject, Identifiable {
    
    class func fetchRequest() -> NSFetchRequest<CDFavour> {
        NSFetchRequest<CDFavour>(entityName: className)
    }
    
    @NSManaged public var postId: Int64
    @NSManaged public var userId: Int64
    
}

extension CDFavour {
    
    func update(postId: Int, userId: Int) {
        self.postId = Int64(postId)
        self.userId = Int64(userId)
    }
    
    static func getFavourPostIds(userId: Int, context: NSManagedObjectContext) -> [Int] {
        
        let fetchRequest = CDFavour.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId = \(userId)")
        do {
            return try context.fetch(fetchRequest).map { Int($0.postId) }
        } catch let error {
            print("failed to fetch favours Ids: \(error)")
            return []
        }
    }
    
    static func setFavour(postId: Int, userId: Int, _ isFavour: Bool, context: NSManagedObjectContext) {
        
        if isFavour {
            
            if getFavour(postId: postId, userId: userId, context: context) != nil { return }
            CDFavour(context: context).update(postId: postId, userId: userId)
            context.saveContext()
            return
            
        }
            
        if let object = getFavour(postId: postId, userId: userId, context: context) {
            context.delete(object)
            context.saveContext()
        }
    }
    
    private static func getFavour(postId: Int, userId: Int, context: NSManagedObjectContext) -> CDFavour? {
        let fetchRequest = CDFavour.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId = \(userId) AND postId = \(postId)")
        return (try? context.fetch(fetchRequest))?.first
    }
}
