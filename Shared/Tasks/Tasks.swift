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
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing:
                    Button(action: {self.showingAddScreen.toggle()},
                           label: {Image(systemName: "plus")})
                )
            .sheet(isPresented: $showingAddScreen) { AddTaskView() } //.environment(\.managedObjectContext, self.moc)
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
                    .foregroundColor(.white)
            })
            .padding(.leading, 25)
            VStack(alignment: .leading){
                Text(displayedTask.name ?? "no title")
//                    .font(.title)
                    .font(.system(size: 18, weight: .heavy, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(displayedTask.desc ?? "")
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.white)
            }
            .frame(width: 140, height: 80)
            .padding(.leading, 15)
//            Spacer()
            VStack(alignment: .center) {
                Text("Created:")
                    .foregroundColor(.white)
                    .font(.caption)
                Text(DateToString(displayedTask.dateCreated!))
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                Text("Due At:")
                    .foregroundColor(.white)
                    .font(.caption)
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
        eTask.dateCreated = Date()
        
        return NavigationView {
            TaskListView(displayedTask: eTask)
        }
//        .preferredColorScheme(.dark)
    }
}

