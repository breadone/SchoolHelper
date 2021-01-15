//
//  Classes.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI

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
    
    @State private var name: String = ""
    @State private var sub: Subject = Subject()
    @State private var sTime: Date = Date()
    @State private var eTime: Date = Date()
    @State private var day: Date = Date()
    
    var body: some View {
        Form {
            Section {
                Text("hi")
            }
        }
    }
}

struct timetableView: View {
    var body: some View {
        Text("placeholder")
    }
}

struct Timetable_Previews: PreviewProvider {
    static var previews: some View {
        Timetable()
    }
}
