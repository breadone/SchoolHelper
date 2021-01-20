//
//  Subject+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 21/01/21.
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
    @NSManaged public var subjectTask: NSSet?

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

// MARK: Generated accessors for subjectTask
extension Subject {

    @objc(addSubjectTaskObject:)
    @NSManaged public func addToSubjectTask(_ value: Subject)

    @objc(removeSubjectTaskObject:)
    @NSManaged public func removeFromSubjectTask(_ value: Subject)

    @objc(addSubjectTask:)
    @NSManaged public func addToSubjectTask(_ values: NSSet)

    @objc(removeSubjectTask:)
    @NSManaged public func removeFromSubjectTask(_ values: NSSet)

}

extension Subject : Identifiable {

}
