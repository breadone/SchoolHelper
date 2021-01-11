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

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { task in                    
                    HStack {
                        Text(DateToString(task.dueDate!))
                        NavigationLink(destination: DetailedTaskView(task: task)) {
                            Text(task.name!)
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing:
                    Button(action: {self.showingAddScreen.toggle()},
                           label: {Image(systemName: "plus")})
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddTaskView() //.environment(\.managedObjectContext, self.moc)
                }
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM"
        return(formatter1.string(from: date))
    }
    
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}

