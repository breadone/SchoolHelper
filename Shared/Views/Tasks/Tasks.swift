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

    var activeFetchRequest: FetchRequest<TaskItem>
    var inactiveFetchRequest: FetchRequest<TaskItem>
    @State private var showingAddScreen = false
    @State private var showingInactive = false

    init() {
        activeFetchRequest = FetchRequest<TaskItem>(entity: TaskItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dateCreated, ascending: false)], predicate: NSPredicate(format: "isActive == true"))
        
        inactiveFetchRequest = FetchRequest<TaskItem>(entity: TaskItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dateCreated, ascending: false)], predicate: NSPredicate(format: "isActive == false"))
    }
    var activeTasks: FetchedResults<TaskItem> {activeFetchRequest.wrappedValue}
    var inactiveTasks: FetchedResults<TaskItem> {inactiveFetchRequest.wrappedValue}
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Active Tasks")
                    .font(.caption)
                ForEach(activeTasks, id: \.self) { task in
                    NavigationLink(destination: DetailedTaskView(task: task)) {
                            TaskListView(displayedTask: task)
                    }
                }
                if showingInactive {
                    Text("Completed Tasks")
                        .font(.caption)
                    ForEach(inactiveTasks, id: \.self) { task in
                            NavigationLink(destination: DetailedTaskView(task: task)) {
                                TaskListView(displayedTask: task)
                        }
                    }
                    .transition(.slide)
//                    .animation(.easeIn(duration: 0.25))
                }
            }
            .navigationBarTitle("Tasks: \(activeTasks.count)")
            .navigationBarItems(leading: Button(action: {withAnimation{self.showingInactive.toggle()}},
                                                label: { Text(showingInactive ? "Completed: On" : "Completed: Off") }
                                                ),
                                trailing: Button(action: {self.showingAddScreen.toggle()},
                                                 label: { Image(systemName: "plus") }
                                                )
                                )
            .sheet(isPresented: $showingAddScreen) { AddTaskView() }
        }
    }
    
}

struct TaskListView: View {
    @Environment(\.managedObjectContext) var moc
    var displayedTask: TaskItem
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        HStack() {
            VStack {
                Button(action: {withAnimation{DoneItem(displayedTask, del: false)}}, label: {
                    Image(systemName: "checkmark.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                })
                .padding(.leading, 25)
                .padding(.bottom, 5)
                Button(action: {showingDeleteAlert.toggle()}, label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                })
                .padding(.leading, 25)
                .padding(.top, 5)
            }
            VStack(alignment: .leading){
                Text(displayedTask.name ?? "no title")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                Text(displayedTask.desc ?? "")
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.white)
            }
            .frame(width: 150, height: 80, alignment: .leading)
            .padding(.leading, 15)
            VStack(alignment: .center) {
                Text("Subject:")
                    .foregroundColor(.white)
                    .font(.caption)
                Text(displayedTask.subject?.name ?? "General")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                Text("Due:")
                    .foregroundColor(.white)
                    .font(.caption)
                Text(DateToString(displayedTask.dueDate ?? Date())).foregroundColor(.white)
                    .font(.subheadline)
            }
            .padding()
            
        }
        .frame(width: 350, height: 100)
        .background(Constants.colourDict[displayedTask.subject?.colour ?? "blue"])
        .cornerRadius(17)
        .alert(isPresented: $showingDeleteAlert, content: {
                Alert(title:
                        Text("Delete Task?"),
                      primaryButton: .destructive(Text("Delete")) {DoneItem(displayedTask, del: true)},
                      secondaryButton: .cancel())}
        )
    }
    private func DateToString(_ date: Date) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd/MM, hh:mm"
        return formatter1.string(from: date)
    }
    
    private func DoneItem(_ item: TaskItem, del: Bool) {
        switch del {
        case false:
            item.isActive.toggle()
        case true:
            moc.delete(item)
        }
        try? moc.save()
    }
}

//struct Tasks_Previews: PreviewProvider {
//    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let eTask = TaskItem(context: moc)
//        eTask.name = "test name for task"
//        eTask.desc = "very long description test should go over 2 lines"
//        eTask.dueDate = Date()
//        eTask.dateCreated = Date()
//
//        return NavigationView {
//            TaskListView(displayedTask: eTask)
//        }
//    }
//}

