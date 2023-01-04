//
//  CDComment.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

final class CDComment: NSManagedObject, Identifiable {
    
    class func fetchRequest() -> NSFetchRequest<CDComment> {
        NSFetchRequest<CDComment>(entityName: className)
    }
  
    @NSManaged public var id: Int
    @NSManaged public var postId: Int
    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
}

extension CDComment {
    
    var apiModel: CommentApiModel {
        .init(id: id,
              postId: postId,
              name: name ?? "",
              body: body ?? "",
              email: email)
    }
    
    func update(model: CommentApiModel) {
        id = model.id
        postId = model.postId
        name = model.name
        body = model.body
        email = model.email
    }
    
    static func saveComments(postId: Int, comments: [CommentApiModel], context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: className)
        fetchRequest.predicate = NSPredicate(format: "postId = \(postId)")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        context.executeRequest(deleteRequest)
        
        comments.forEach {
            CDComment(context: context).update(model: $0)
        }
        context.saveContext()
    }
    
    static func getComments(postId: Int, context: NSManagedObjectContext) -> [CommentApiModel] {
        
        let fetchRequest = CDComment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postId = \(postId)")
        return (try? context.fetch(fetchRequest))?.map { $0.apiModel } ?? []
    }
    
}
