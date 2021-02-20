//
//  Dashboard.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI

struct Dashboard: View {
    @Environment(\.managedObjectContext) var moc
    
    var taskFetchRequest: FetchRequest<TaskItem>
    var ttDayFetchRequest: FetchRequest<TimetableEntry>
    
    init(day: String) {
        taskFetchRequest = FetchRequest<TaskItem>(
            entity: TaskItem.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "isActive == true"))
        
        ttDayFetchRequest = FetchRequest<TimetableEntry>(
            entity: TimetableEntry.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \TimetableEntry.startTime, ascending: true)],
            predicate: NSPredicate(format: "day = %@", day))
    }
    
    var tasks: FetchedResults<TaskItem> {taskFetchRequest.wrappedValue}
    var timetableEntries: FetchedResults<TimetableEntry> {ttDayFetchRequest.wrappedValue}
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(tasks, id: \.self) { task in
                    Text(task.name ?? "")
                }
                .frame(width: 150, height: 150)
                .background(RoundedRectangle(cornerRadius: 17))
                .foregroundColor(Constants.darkModeGrey)
                Spacer()
            }
            .padding()
            ScrollView {
                Spacer(minLength: 20)
                ForEach(timetableEntries, id: \.self) {tt in
                    ttView(ttEntry: tt)
                }
            }
            .frame(width: 350, height: 400)
            .background(RoundedRectangle(cornerRadius: 17))
            .foregroundColor(Constants.darkModeGrey)
        }
        .navigationTitle(Text("Dashboard"))
    }
}

struct ttView: View {
    @Environment(\.managedObjectContext) var moc
    let ttEntry: TimetableEntry
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("\(Constants.DateToString(ttEntry.startTime!, format: "KK:mm")) || \(Constants.DateToString(ttEntry.endTime!, format: "KK:mm"))")
                    .font(.caption)
                    .foregroundColor(.white)
                Text(ttEntry.subject?.name ?? "Unknown Name")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(ttEntry.room ?? "Unknown Room")
                    .font(.body)
                    .foregroundColor(.white)
            }
            .padding()
            Spacer()
        }
        .frame(width: 325, height: 100)
        .background(Constants.colourDict[ttEntry.subject?.colour ?? "blue"])
        .cornerRadius(17)
    }
    
    func deletettEntry(_ t: TimetableEntry) {
        moc.delete(t)
        try? moc.save()
    }
    
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(day: "\(Constants.DateToString(Date(), format: "EEEE"))")
    }
}
