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
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { task in
                    NavigationLink(
                        destination: Text(task.desc ?? "no title")) {
                        Text(task.name ?? "no description")
                    }
                }
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing:
                    Button(action: {self.showingAddScreen.toggle()},
                           label: {
                            Image(systemName: "plus")
                           })
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddTaskView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}

//public func AddItem(_ name: String, dueDate: Int) {
//
//}
