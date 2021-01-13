//
//  Tasks.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//
import Foundation
import SwiftUI
import CoreData

struct Tasks: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dateCreated, ascending: false)]) var tasks: FetchedResults<TaskItem>
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(tasks, id: \.self) { task in
                        NavigationLink(destination: DetailedTaskView(task: task)) {
                            TaskListView(displayedTask: task)
                    }
                }
                .onDelete(perform: deleteItem)
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing:
                    Button(action: {self.showingAddScreen.toggle()},
                           label: {Image(systemName: "plus")})
                )
            .sheet(isPresented: $showingAddScreen) { AddTaskView() } //.environment(\.managedObjectContext, self.moc)
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(moc.delete)
            try? self.moc.save()
        }
    }
}

struct TaskListView: View {
    @Environment(\.managedObjectContext) var moc
    var displayedTask: TaskItem
    
    var body: some View {
        HStack() {
            Button(action: {DeleteItem(item: displayedTask)}, label: {
                Image(systemName: "checkmark.square")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            })
            .padding(.leading, 15)
            VStack(alignment: .leading){
                Text(displayedTask.name ?? "no title")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text(displayedTask.desc ?? "")
                    .lineLimit(2)
                    .foregroundColor(.white)
            }
            .frame(width: 140, height: 80)
            .padding()
//            Spacer()
            VStack(alignment: .center) {
                Text("Due At:").foregroundColor(.white)
                Text(DateToString(displayedTask.dueDate!)).foregroundColor(.white)
            }
            .padding()
            
        }
        .frame(height: 100)
        .background(Color.blue.opacity(17))
        .cornerRadius(17)
    }
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:mm"
        return(formatter1.string(from: date))
    }
    
    private func DeleteItem(item: TaskItem) {
        moc.delete(item)
        try? moc.save()
    }
}

struct Tasks_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let eTask = TaskItem(context: moc)
        eTask.name = "test title"
        eTask.desc = "test description"
        eTask.dueDate = Date()
        
        return NavigationView {
            TaskListView(displayedTask: eTask)
        }
//        .preferredColorScheme(.dark)
    }
}

