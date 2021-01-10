//
//  TaskItem+CoreDataProperties.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 10/01/21.
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
    @NSManaged public var name: String?
    @NSManaged public var dueDate: Date?

}

extension TaskItem : Identifiable {

}
