//
//  CDPost.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

final class CDPost: NSManagedObject, Identifiable {
    
    class func fetchRequest() -> NSFetchRequest<CDPost> {
        NSFetchRequest<CDPost>(entityName: className)
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var userId: Int64
    
}

extension CDPost {

    var apiModel: PostApiModel {

        .init(id: Int(id),
              userId: Int(userId),
              title: title ?? "",
              body: body ?? "")
    }
    
    func update(model: PostApiModel) {
        id = Int64(model.id)
        userId = Int64(model.userId)
        title = model.title
        body = model.body
    }
    
    static func savePosts(userId: Int, posts: [PostApiModel], context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        fetchRequest.predicate = NSPredicate(format: "userId = \(userId)")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        context.executeRequest(deleteRequest)
        
        posts.forEach {
            CDPost(context: context).update(model: $0)
        }
        context.saveContext()
    }
    
    static func getPosts(userId: Int, context: NSManagedObjectContext) -> [PostApiModel] {
        
        let fetchRequest = CDPost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId = \(userId)")
        return (try? context.fetch(fetchRequest))?.map { $0.apiModel } ?? []
    }
    
}
