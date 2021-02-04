//
//  EditTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 12/01/21.
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    let task: TaskItem
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var Newname: String
    @State var NewmoreInfo: String
    @State private var NewdueDate = Date()
    @State private var hasDueDate = false
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Name")) {
                        TextField(task.name ?? "no title", text: $Newname)
                    }
                    Section(header: Text("More Info")) {
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
                .toolbar{
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: { EditTask(editedTask: task) },
                               label: { Text("Done") }
                        )
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {DismissSheet()},
                               label: { Text("Cancel").foregroundColor(.red) }
                        )
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
            EditTaskView(task: eTask, Newname: eTask.name!, NewmoreInfo: eTask.desc!)
                
        }

    }
}
