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
                NavigationLink(destination: AddSubjectView(), label: {
                    Text("Add Classes")
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(.white)
                })
                .padding()
                .frame(width: 350, height: 100, alignment: .center)
                .background(Color.blue)
                .cornerRadius(17)
                .navigationBarTitle("Timetable")
                
                NavigationLink(
                    destination: SubjectListView(),
                    label: {
                        Text("View Classes")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.white)
                    })
                    .padding()
                    .frame(width: 350, height: 100, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(17)
                    .navigationBarTitle("Timetable")
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
