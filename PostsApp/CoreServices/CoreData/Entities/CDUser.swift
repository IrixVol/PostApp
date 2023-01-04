//
//  CDUser.swift
//  PostsApp
//
//  Created by Tatiana Blagoobrazova on 03.01.2023.
//

import Foundation
import CoreData

final class CDUser: NSManagedObject, Identifiable {
    
    class func fetchRequest() -> NSFetchRequest<CDUser> {
        NSFetchRequest<CDUser>(entityName: className)
    }
    
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var username: String
    @NSManaged public var email: String?
}

extension CDUser {
    
    var apiModel: UserApiModel {
        .init(id: id,
              name: name,
              username: username,
              email: email)
    }
    
    func update(model: UserApiModel) {
        id = model.id
        name = model.name
        username = model.username
        email = model.email
    }
    
    static func saveUser(_ userModel: UserApiModel, context: NSManagedObjectContext) {
        
        let user = getUser(userId: userModel.id, context: context) ?? CDUser(context: context)
        user.update(model: userModel)
        context.saveContext()
    }
    
    static func getUser(userId: Int, context: NSManagedObjectContext) -> CDUser? {
        let fetchRequest = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = \(userId)")
        return (try? context.fetch(fetchRequest))?.first
    }
}
