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
                    Image(systemName: "text.book.closed.fill")
                    Text("Dashboard")
                }
            Classes()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Classes")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
