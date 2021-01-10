//
//  AddTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 10/01/21.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var dateCreated = Date()
    @State private var moreInfo = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task", text: $name)
                    TextField("Write a Description", text: $moreInfo)
                }
                
                Section {
                    DatePicker("Due Date", selection: $dueDate)
                }

                Section {
                    Button("Save Task") {
                        AddTask()
                        DismissSheet()
                    }
                }
            }
            .navigationBarTitle("Add New Task")
            .navigationBarItems(leading: Button(action: {DismissSheet()}, label: {
                Text("Cancel")
                    .foregroundColor(Color.red)
            }))
        }
    }
    
    func AddTask() {
        let newTask = TaskItem(context: self.moc)
        newTask.name = self.name
        newTask.dateCreated = Date()
        newTask.desc = self.moreInfo
        newTask.dueDate = self.dueDate
        
        try? self.moc.save()
    }
    
    func DismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}


