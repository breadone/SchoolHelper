//
//  ContentView.swift
//  Shared
//
//  Created by Pradyun Setti on 9/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Dashboard()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Dashboard")
                }
            Timetable()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Timetable")
                }
            Tasks()
                .tabItem {
                    Image(systemName: "checkmark.square")
                    Text("Tasks")
                }
            Me()
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
