//
//  AddClassesView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 14/01/21.
//

import SwiftUI
import CoreData


struct AddSubjectView: View {
    @Environment(\.managedObjectContext) var moc

    @State var name: String = "Name"
    @State var teacher: String = "No Teacher"
    @State var colour: Int = 0
    
    var subjectColours = ["blue", "green", "red", "grey", "pink", "purple", "yellow", "orange"]
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
        VStack {
            Form {
                Section {
                    TextField("Name of Subject", text: $name)
                }
                Section {
                    TextField("Name of Teacher/Professor", text: $teacher)
                }
                Section {
                    Picker(selection: $colour, label: Text("Choose a Color")) {
                        ForEach(0 ..< subjectColours.count) {
                            Text(self.subjectColours[$0])
                                .padding()
                                .frame(height: 25)
                                .background(colourDict[subjectColours[$0]])
                                .cornerRadius(17)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Add Subject")
        .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {Text("Save")}))
    }
    
    
    private func saveSubject() {
        let newSub = Subject(context: self.moc)
        newSub.id = UUID()
        newSub.name = name
        newSub.teacher = teacher
        newSub.colour = subjectColours[colour]
        
    }
    
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
    }
}
