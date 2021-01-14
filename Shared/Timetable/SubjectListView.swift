//
//  SubjectListView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 14/01/21.
//

import SwiftUI
import CoreData

struct SubjectListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subjects: FetchedResults<Subject>
    
    var body: some View {
        Text("test")
    }

}

struct ListCard: View {
    var sub: Subject
    
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
        HStack {
            VStack(alignment: .leading) {
                Text(sub.name ?? "")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 350, height: 100)
        .background(colourDict[sub.colour!])
        .cornerRadius(17)
        .shadow(radius: 7)
    }
}

struct SubjectListView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let tSub = Subject(context: moc)
        tSub.name = "A2 Physics"
        tSub.teacher = "MEE"
        tSub.colour = "green"
        
        return NavigationView {
            ListCard(sub: tSub)
        }
    }
}
