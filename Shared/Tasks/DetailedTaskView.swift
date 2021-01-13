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
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State var EditMode = false
    @State var TaskDone = false
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack {
                    Text(task.desc ?? "no description")
                        .padding()
                        .navigationBarTitle(task.name ?? "no title", displayMode: .automatic)
                        .navigationBarItems(trailing: Button(action: {EditMode.toggle()}, label: {
                            Text("Edit")
                        }))
                        .sheet(isPresented: $EditMode, content: {
                            EditTaskView(task: task)
                    })
                    Spacer()
                }

            }
            Spacer()
            Button(action: {DoneTask(task: task)}, label: {
                    Text("Completed")
                        .foregroundColor(.white)
            })
                .frame(width: 280, height: 50, alignment: .center)
                .background(Color.green)
                .cornerRadius(17)
                .padding()
        }
    }
        
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM"
        return(formatter1.string(from: date))
    }
    
    func DoneTask(task: TaskItem) {
        task.isActive = false
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
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
