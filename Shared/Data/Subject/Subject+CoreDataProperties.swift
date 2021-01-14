//
//  Subject+CoreDataProperties.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 14/01/21.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var name: String?
    @NSManaged public var teacher: String?
    @NSManaged public var colour: String?
    @NSManaged public var id: UUID?
    @NSManaged public var avgGrade: Int16
    @NSManaged public var totalGrade: Int16
    @NSManaged public var gradeCount: Int16

}

extension Subject: Identifiable {

}
