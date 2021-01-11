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
    
    var body: some View {
        VStack(alignment: .leading) {
                Text(self.task.desc ?? "no desc")
                    .font(.body)
                    .padding()
            Spacer()
        }
        .navigationBarTitle(task.name ?? "no title", displayMode: .automatic)
        .navigationBarItems(trailing: Text("Due On: \(DateToString(task.dueDate!))"))
    }
    
    public func DateToString(_ date: Date) -> String {
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
        eTask.desc = """
            test description
            another line
            and another one
        """
        eTask.dueDate = Date()
        
        return NavigationView {
            DetailedTaskView(task: eTask)
        }
    }
}
