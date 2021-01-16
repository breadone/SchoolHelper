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
    @FetchRequest(entity: TimetableEntry.entity(), sortDescriptors: []) var timeslots: FetchedResults<TimetableEntry>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("temp")
                .navigationBarTitle("Timetable")
                .navigationBarItems(leading: NavigationLink(
                                        destination: SubjectListView(),
                                        label: { Text("View Classes") }),
                                    trailing: NavigationLink(
                                        destination: AddTTEntry(),
                                        label: {
                                            Text("Add Timetable")
                                        }))
            }
        }
    }
}

struct AddTTEntry: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subIn: FetchedResults<Subject>
    
    var colourDict = ["blue": Color.blue,
                      "green": Color.green,
                      "red": Color.red,
                      "grey": Color.gray,
                      "pink": Color.pink,
                      "purple": Color.purple,
                      "yellow": Color.yellow,
                      "orange": Color.orange
    ]
    
    var days = ["mon", "tue", "wed", "thurs", "fri", "sat", "sun"]
    
    @State private var room: String = ""
    @State private var sub: Subject = Subject()
    @State private var sTime: Date = Date()
    @State private var eTime: Date = Date()
    @State private var day: String = ""
    
    var body: some View {
        Form {
            Section {
                Picker("Select Subject", selection: $sub) {
                    ForEach(subIn, id: \.id) { subin in
                        Text(subin.name ?? "")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(colourDict[subin.colour ?? "blue"])
                            .cornerRadius(17)
                    }
                }
            }
            Section {
                TextField("Enter Location", text: $room)
            }
            
            Section {
                Picker("Day", selection: $day) {
                    ForEach(0..<days.count) {
                        Text(days[$0])
                    }
                }
                DatePicker("Start Time", selection: $sTime, displayedComponents: [.hourAndMinute])
                DatePicker("End Time", selection: $eTime, displayedComponents: [.hourAndMinute])
            }
        }
        .navigationBarTitle("Add Timetable Entry")
        .navigationBarItems(trailing: Button(action: { saveTT() }, label: {Text("Save")}))
    }
    
    func saveTT() {
        let tt = TimetableEntry(context: moc)
        tt.startTime = sTime
        tt.endTime = eTime
        tt.day = day
        tt.subject = sub
        tt.room = room
        try? moc.save()
    }
    
    func dateFormatter(_ date: Date) -> Date {
        
        return Date()
    }
    
}

struct timetableListView: View {
    var ttEntry: TimetableEntry
    
    var colourDict = ["blue": Color.blue,
                      "green": Color.green,
                      "red": Color.red,
                      "grey": Color.gray,
                      "pink": Color.pink,
                      "purple": Color.purple,
                      "yellow": Color.yellow,
                      "orange": Color.orange
    ]
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("startTime || endTime")
                    .font(.caption)
                    .foregroundColor(.white)
                Text(ttEntry.subject?.name ?? "no name")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(ttEntry.room ?? "no room")
                    .font(.body)
                    .foregroundColor(.white)
            }
            .padding()
            Spacer()
        }
        .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .background(colourDict[ttEntry.subject?.colour ?? "blue"])
        .cornerRadius(17)
    }
}

struct Timetable_Previews: PreviewProvider {
    static let eMoc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let eSub = Subject(context: eMoc)
        eSub.name = "A2 Physics"
        eSub.teacher = "MEE"
        eSub.colour = "red"
        
        let TT = TimetableEntry(context: eMoc)
        TT.day = "sun"
        TT.startTime = Date().addingTimeInterval(-7200)
        TT.endTime = Date().addingTimeInterval(7200)
        TT.room = "T203"
        TT.subject = eSub
        
        return NavigationView {
            timetableListView(ttEntry: TT)
        }
    }
}
