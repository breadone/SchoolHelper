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

    @NSManaged public var avgGrade: Double
    @NSManaged public var name: String?
    @NSManaged public var teacher: String?

}

extension Subject : Identifiable {

}
