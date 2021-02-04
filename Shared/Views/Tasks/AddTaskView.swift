//
//  AddTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 10/01/21.
//

import Foundation
import SwiftUI
import CoreData
import UserNotifications

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subject: FetchedResults<Subject>
    
    @State private var name = ""
    @State private var dateCreated = Date()
    @State private var moreInfo = ""
    @State private var dueDate = Date()
    @State private var sub: Subject?
    @State private var hasDueDate = false
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Name")) {
                        TextField("", text: $name)
                    }
                    Section(header: Text("More Info")) {
                        TextEditor(text: $moreInfo)
                            .font(.body)
                            .lineLimit(15)
                            .frame(height: 200)
                    }
                    Section() {
                        Picker("Select Subject, leave blank for none", selection: $sub) {
                            ForEach(subject, id: \.self) { sub in
                                Text(sub.name ?? "")
                            }
                        }
                    }
                    Section {
                        VStack {
                            Toggle(isOn: $hasDueDate, label: {
                                Label("Due Date", systemImage: "deskclock")
                            })
                            if self.hasDueDate {
                                DatePicker("Date/Time:", selection: $dueDate)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .labelsHidden()
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
        newTask.subject = sub
        newTask.name = self.name
        newTask.dateCreated = Date()
        newTask.desc = self.moreInfo
        newTask.dueDate = self.dueDate
        newTask.isActive = true
        
        if hasDueDate {
            AddAlert()
        }
        
        try? self.moc.save()
        DismissSheet()
    }
    
    func DismissSheet() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func AddAlert() {
        let content = UNMutableNotificationContent()
        content.title = "Task Due!"
        content.subtitle = name
        content.sound = UNNotificationSound.default
        
        let delay = Calendar.current.dateComponents([.second], from: Date(), to: dueDate)        
        let trigger = UNCalendarNotificationTrigger(dateMatching: delay, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}


