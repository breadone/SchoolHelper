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
    
    @State private var hasDueDate = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task", text: $name)
                }
                Section {
                    TextEditor(text: $moreInfo)
//                        .font(.body)
//                        .lineLimit(15)
//                        .padding(.top, -90)
//                        .frame(height: 200)
                }
                Section {
                    VStack {
                        Toggle(isOn: $hasDueDate, label: {
                            HStack {
                                Image(systemName: "deskclock.fill")
                                    .renderingMode(.original)
                                Text("Due Date")
                            }
                        })
                        if self.hasDueDate {
                            DatePicker("Date/Time:", selection: $dueDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Add New Task")
            .navigationBarItems(leading: Button(action: {DismissSheet()}, label: {
                Text("Cancel")
                    .foregroundColor(Color.red)
            }), trailing: Button(action: {AddTask()}, label: {
                Text("Done")
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
        DismissSheet()
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


