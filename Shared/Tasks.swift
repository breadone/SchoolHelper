//
//  Tasks.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//
import Foundation
import SwiftUI
import CoreData

struct Tasks: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dateCreated, ascending: false)]) var tasks: FetchedResults<TaskItem>
    
    @State private var showingAddScreen = false
    @State private var noDueDate = false

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { task in                    
                    HStack {
//                        Text(noDueDate ? "" : DateToString(task.dueDate!))
                       Text("08/10")
                        NavigationLink(
                            destination: Text(task.desc ?? "no title")) {
                            Text(task.name ?? "no description")
                        }
                    }
                }
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing:
                    Button(action: {self.showingAddScreen.toggle()},
                           label: {Image(systemName: "plus")})
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddTaskView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
    
    func DateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}

