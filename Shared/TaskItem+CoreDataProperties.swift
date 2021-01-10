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
    @NSManaged public var dateDue: Date?
    @NSManaged public var name: String?

}

extension TaskItem : Identifiable {

}
