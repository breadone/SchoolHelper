//
//  TaskItem.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//

import Foundation
import CoreData

public class TaskItem:NSManagedObject, Identifiable {
    @NSManaged public var name:String?
    @NSManaged public var moreInfo:String?
    @NSManaged public var dateCreated:Date?
    @NSManaged public var dateDue:Date?
    
    
}
