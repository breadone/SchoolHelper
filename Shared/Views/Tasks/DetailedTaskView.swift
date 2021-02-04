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
    
    var body: some View {
        VStack(alignment: .center) {
                    Text(task.desc ?? "no description")
                        .padding()
                        .padding(.top, 20)
                        .frame(width: 370, height: 550, alignment: .topLeading)
                        .navigationBarTitle(task.name ?? "no title", displayMode: .automatic)
                        .navigationBarItems(trailing: Button(action: {EditMode.toggle()}, label: {
                            Text("Edit")
                        }))
                        .sheet(isPresented: $EditMode, content: {
                            EditTaskView(task: task, Newname: task.name!, NewmoreInfo: task.desc!)
                    })
            Spacer()
            Button(action: {DoneTask(task)}, label: {
                    Text("Completed")
                        .foregroundColor(.white) })
                .frame(width: 280, height: 50, alignment: .center)
                .background(Color.green)
                .cornerRadius(17)
                .padding(.bottom, 50)
        }
    }
        
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:ss"
        return(formatter1.string(from: date))
    }
    
    func DoneTask(_ task: TaskItem) {
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
        eTask.desc = "test description asldkfjalsdkjflaskdjflsakjdfhlaskdjfhlaksjdfhlksajdhflksajdfhlaksjdfhlkasjdhflj"
        eTask.dueDate = Date()
        
        return NavigationView {
            DetailedTaskView(task: eTask)
        }
    }
}
