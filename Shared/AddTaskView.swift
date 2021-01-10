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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task", text: $name)
                    TextField("Write a Description", text: $moreInfo)
                }

                Section {
                    Button("Save Task") {
                        let newTask = TaskItem(context: self.moc)
                        newTask.name = self.name
                        newTask.dateCreated = Date()
                        newTask.desc = self.moreInfo
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add New Task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
