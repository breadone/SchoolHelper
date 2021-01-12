//
//  DetailedTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 11/01/21.
//

import SwiftUI
import CoreData

struct DetailedTaskView: View {
    let task: TaskItem
    @State var EditMode = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.desc ?? "no description")
                    .padding()
                    .navigationBarTitle(task.name ?? "no title", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {EditMode.toggle()}, label: {
                        Text("Edit")
                    }))
                    .sheet(isPresented: $EditMode, content: {
                        AddTaskView()
                })
                Spacer()
            }
            Spacer()
        }
    }
    
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM"
        return(formatter1.string(from: date))
    }
}

struct DetailedTaskView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let eTask = TaskItem(context: moc)
        eTask.name = "test title"
        eTask.desc = "test description"
        eTask.dueDate = Date()
        
        return NavigationView {
            DetailedTaskView(task: eTask)
        }
    }
}
