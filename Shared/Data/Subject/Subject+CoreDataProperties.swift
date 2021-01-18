//
//  Subject+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 17/01/21.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var avgGrade: Int16
    @NSManaged public var colour: String?
    @NSManaged public var gradeCount: Int16
    @NSManaged public var name: String?
    @NSManaged public var teacher: String?
    @NSManaged public var totalGrade: Int16
    @NSManaged public var subjectTT: NSSet?

    public var subArray: [TimetableEntry] {
        Array(subjectTT as? Set<TimetableEntry> ?? [])
    }
    
}

// MARK: Generated accessors for subjectTT
extension Subject {

    @objc(addSubjectTTObject:)
    @NSManaged public func addToSubjectTT(_ value: TimetableEntry)

    @objc(removeSubjectTTObject:)
    @NSManaged public func removeFromSubjectTT(_ value: TimetableEntry)

    @objc(addSubjectTT:)
    @NSManaged public func addToSubjectTT(_ values: NSSet)

    @objc(removeSubjectTT:)
    @NSManaged public func removeFromSubjectTT(_ values: NSSet)

}

extension Subject : Identifiable {

}
