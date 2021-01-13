//
//  EditTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 12/01/21.
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let task: TaskItem
    
    @State private var Newname = ""
    @State private var NewmoreInfo = ""
    @State private var NewdueDate = Date()
    @State private var hasDueDate = false

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        TextField(task.name ?? "no title", text: $Newname)
                    }
                    Section {
                        TextEditor(text: $NewmoreInfo)
                            .font(.body)
                            .lineLimit(15)
                            .frame(height: 200)
                    }
    //                Section {
    //                    VStack {
    //                        Toggle(isOn: $hasDueDate, label: {
    //                            Label("Due Date", systemImage: "deskclock")
    //                        })
    //                        if self.hasDueDate {
    //                            DatePicker("Date/Time:", selection: $NewdueDate)
    //                                .datePickerStyle(GraphicalDatePickerStyle())
    //                                .labelsHidden()
    //                        }
    //                    }
    //                }
                }
                .navigationBarTitle("Edit Task")
                .navigationBarItems(leading: Button(action: {DismissSheet()}, label: {
                    Text("Cancel")
                        .foregroundColor(Color.red)
                }), trailing: Button(action: {EditTask(editedTask: task)}, label: {
                    Text("Done")
                }))
                
                VStack {
                    Text("Name")
                        .offset(x: -145, y: -280)
                        .foregroundColor(.secondary)
                    Text("Description")
                        .offset(x: -125, y: -220)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    func EditTask(editedTask: TaskItem) {
        if Newname != "" {
            editedTask.name = self.Newname
        }
        if NewmoreInfo != "" {
            editedTask.desc = self.NewmoreInfo

        }
//        editedTask.dueDate = self.NewdueDate
        
        try? self.moc.save()
        DismissSheet()
    }
    
    func DismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let eTask = TaskItem(context: moc)
        eTask.name = "test title"
        eTask.desc = "test description"
        eTask.dueDate = Date()

        return NavigationView {
            EditTaskView(task: eTask)
                
        }

    }
}
