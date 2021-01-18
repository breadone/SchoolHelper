//
//  TimetableEntry+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 17/01/21.
//
//

import Foundation
import CoreData


extension TimetableEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableEntry> {
        return NSFetchRequest<TimetableEntry>(entityName: "TimetableEntry")
    }

    @NSManaged public var day: String?
    @NSManaged public var endTime: Date?
    @NSManaged public var room: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var subject: Subject?

}

//extension TimetableEntry {
//
//    @objc(addSubjectObject:)
//    @NSManaged public func addSubjectToTimetable(_ value: Subject)
//
//    @objc(addSubject:)
//    @NSManaged public func addToSubject(_ value: Subject)
//
//
//}

extension TimetableEntry : Identifiable {

}
