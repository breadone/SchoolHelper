//
//  TimetableEntry+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 14/01/21.
//
//

import Foundation
import CoreData


extension TimetableEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableEntry> {
        return NSFetchRequest<TimetableEntry>(entityName: "TimetableEntry")
    }
    
//    @NSManaged public var subject: Subject?
    @NSManaged public var day: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?

}

extension TimetableEntry : Identifiable {

}
