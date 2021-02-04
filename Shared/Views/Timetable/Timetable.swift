//
//  Classes.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI
import CoreData

struct Timetable: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: TimetableEntry.entity(), sortDescriptors: [NSSortDescriptor(key: "startTime", ascending: true)])
    
    var dayFetchRequest: FetchRequest<TimetableEntry>
    
    init(day: String) {
        dayFetchRequest = FetchRequest<TimetableEntry>(entity: TimetableEntry.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TimetableEntry.startTime, ascending: true)], predicate: NSPredicate(format: "day = %@", day))
    }
    
    var timeslots: FetchedResults<TimetableEntry> {dayFetchRequest.wrappedValue}
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(timeslots, id: \.self) {t in
                    timetableListView(ttEntry: t)
                }
                .navigationBarTitle("\(Constants.TodayAsString())")
                .navigationBarItems(leading: NavigationLink(
                                        destination: SubjectListView(),
                                        label: { Text("View Classes") }),
                                    trailing: NavigationLink(
                                        destination: AddTTEntry(),
                                        label: { Image(systemName: "plus") }))
            }
        }
    }
    
}

struct AddTTEntry: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presmode
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: [])
    private var subIn: FetchedResults<Subject>
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @State private var room: String = ""
    @State private var sub: Subject = Subject()
    @State private var sTime: Date = Date()
    @State private var eTime: Date = Date()
    @State private var day: String = ""
    
    init() {
        sub = Subject(context: moc)
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Select Subject", selection: $sub) {
                    ForEach(subIn, id: \.self) { subin in
                        Text(subin.name ?? "")
                            .foregroundColor(Color.white)
                            .padding(.leading, 20).padding(.trailing, 20).padding(.top, 10).padding(.bottom, 10)
                            .background(Constants.colourDict[subin.colour ?? "blue"])
                            .cornerRadius(17)
                    }
                }
            }
            Section {
                TextField("Enter Location", text: $room)
            }
            
            Section() {
                Picker("Day", selection: $day) {
                    ForEach(self.days, id: \.self) { day in
                        Text(day)
                    }
                }
                .id(self.days)
                DatePicker("Start", selection: $sTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                DatePicker("End", selection: $eTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .navigationBarTitle("Add Timetable Entry")
        .navigationBarItems(trailing: Button(action: { saveTT() }, label: {Text("Save")}))
    }
    
    func saveTT() {
        let tt = TimetableEntry(context: self.moc)
        tt.startTime = sTime
        tt.endTime = eTime
        tt.day = day
        tt.room = room
        tt.subject = sub
        
        try? moc.save()
        presmode.wrappedValue.dismiss()
    }
    

}

struct timetableListView: View {
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
        .frame(width: 350, height: 100)
        .background(Constants.colourDict[ttEntry.subject?.colour ?? "blue"])
        .cornerRadius(17)
        .contextMenu(ContextMenu(menuItems: {
            Button(action: {withAnimation{deletettEntry(ttEntry)}}, label: {
                Text("Delete Entry")
                Image(systemName: "trash")
            })
        }))
    }
    
    func deletettEntry(_ t: TimetableEntry) {
        moc.delete(t)
        try? moc.save()
    }
    
}

//struct Timetable_Previews: PreviewProvider {
//    static let eMoc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let eSub = Subject(context: eMoc)
//        eSub.name = "A2 Physics"
//        eSub.teacher = "MEE"
//        eSub.colour = "red"
//
//        let TT = TimetableEntry(context: eMoc)
//        TT.day = "sun"
//        TT.startTime = Date().addingTimeInterval(-7200)
//        TT.endTime = Date().addingTimeInterval(7200)
//        TT.room = "T203"
//        TT.subject = eSub
//
//        return NavigationView {
//            timetableListView(ttEntry: TT)
//
//        }
//    }
//}
