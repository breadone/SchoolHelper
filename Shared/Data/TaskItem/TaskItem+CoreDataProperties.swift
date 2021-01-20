//
//  TaskItem+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 21/01/21.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var desc: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var subject: Subject?

}

extension TaskItem : Identifiable {

}
