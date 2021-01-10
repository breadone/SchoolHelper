//
//  Tasks.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI
import CoreData

struct Tasks: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: []) var tasks: FetchedResults<TaskItem>
    
    var body: some View {
        VStack {
            List {
                ForEach(tasks) { tasks in
                    Text(tasks.name ?? "unknown")
                }
            }
            Button("Add") {
//                let taskname = ["compsci hw", "physics hw", "bio hw", "math hw"]
                let chosenName = "taskname.randomElement()!"
                
                let task = TaskItem(context: self.moc)
                task.name = "\(chosenName)"
                
                try? self.moc.save()
            }
        }
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}
