//
//  Item+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Narayana Wijaya on 31/07/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
}

extension Item : Identifiable {

}
