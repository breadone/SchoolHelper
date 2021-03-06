//
//  Persistence.swift
//  coredata tests
//
//  Created by Pradyun Setti on 10/01/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
            let newTaskItem = TaskItem(context: viewContext)
            newTaskItem.dateCreated = Date()
            newTaskItem.desc = ""
            newTaskItem.name = ""
            newTaskItem.isActive = true
        }
        
        for _ in 0..<10 {
            let newTimetableEntry = TimetableEntry(context: viewContext)
            newTimetableEntry.startTime = Date()
            newTimetableEntry.startTime = Date()
            newTimetableEntry.day = ""
            newTimetableEntry.room = ""
//            newTimetableEntry.subject = Subject()
        }
        
        for _ in 0..<10 {
            let newSubject = Subject(context: viewContext)
            newSubject.name = ""
            newSubject.teacher = ""
            newSubject.avgGrade = 0
            newSubject.colour = ""
            newSubject.gradeCount = 0
            newSubject.totalGrade = 0
//            newSubject.subjectTT = []
        }
        

        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SchoolHelper")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
