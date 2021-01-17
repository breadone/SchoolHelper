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
    
    @State private var ShowingAddTest: Bool = false
    
    var body: some View {
        ScrollView {
            ForEach(subjects, id: \.id) { sub in
                ListCard(sub: sub)
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: {withAnimation{deleteItem(sub)}}, label: {
                            Image(systemName: "trash")
                            Text("Delete Subject")
                        })
                        
                        Button(action: {ShowingAddTest.toggle()}, label: {
                            Text("Add Test Result")
                            Image(systemName: "plus")
                        })
                    }))
                    .sheet(isPresented: $ShowingAddTest, content: {
                        AddTestForm(subject: sub)
                    })
            }
        }
        .navigationBarTitle("Subjects")
        .navigationBarItems(trailing: NavigationLink(
                                destination: AddSubjectView(),
                                label: { Image(systemName: "plus") }))
    }
    
    func deleteItem(_ item: Subject) {
        moc.delete(item)
        try? moc.save()
    }
}

struct ListCard: View {
    @Environment(\.managedObjectContext) var moc

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
                    .bold()
                Text(sub.teacher ?? "")
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(3)
            }
            .padding()
            .frame(width: 170, height: 100, alignment: .leading)
            Spacer()
            VStack(alignment: .trailing) {
                Text("CURRENT: \(MarkToGrade(Int(avgGrade(sub)) ?? 0))")
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                Text("AVG: \(avgGrade(sub))")
                    .font(.footnote)
                    .foregroundColor(.white)
                Text("AGG: \(sub.totalGrade)")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 350, height: 100)
        .background(colourDict[sub.colour!])
        .cornerRadius(17)
    }
    

    
    func MarkToGrade(_ mark: Int) -> String{
        switch mark {
        case 90...100:
            return "A*"
        case 80...89:
            return "A"
        case 70...79:
            return "B"
        case 60...69:
            return "C"
        case 50...59:
            return "D"
        case 40...49:
            return "E"
        case 0...39:
            return "U"
        default:
            return "error"
        }
    }
    
    func avgGrade(_ s: Subject) -> String {
        if s.gradeCount == 0 {
            return "N/A"
        } else {
            return String(s.totalGrade / s.gradeCount)
        }
    }
}

struct AddTestForm: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var subject: Subject
    @State private var mark: String = ""
    @State private var weight: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Mark", text: $mark)
                        .keyboardType(.numberPad)
                }
                Section {
                    TextField("Enter Weight", text: $weight)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add Test Result")
            .navigationBarItems(trailing: Button(action: {saveResult()}, label: {
                Text("Save")
            }))
        }
    }
    
    func saveResult() {
        subject.gradeCount += 1
        subject.avgGrade = Int16((Int16(mark) ?? 0 ) + subject.totalGrade / subject.gradeCount)
        
        let temp = (Double(mark)!) * (Double(weight)! / 100)
        subject.totalGrade += Int16(temp)
        
        
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddSubjectView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State var name: String = ""
    @State var teacher: String = ""
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
        .navigationBarItems(trailing: Button(action: {saveSubject()}, label: {Text("Save")}))
    }
    
    
    private func saveSubject() {
        let newSub = Subject(context: self.moc)
        newSub.id = UUID()
        newSub.name = name
        newSub.teacher = teacher
        newSub.totalGrade = Int16(0)
        newSub.gradeCount = Int16(0)
        
        newSub.colour = subjectColours[colour]
                
        try? moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct SubjectListView_Previews: PreviewProvider {
    static let eMoc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let eSub = Subject(context: eMoc)
        eSub.name = "A2 Physics"
        eSub.teacher = "MEE"
        eSub.colour = "blue"
        eSub.totalGrade = 83 + 77 + 76 + 88 + 73
        eSub.gradeCount = 5
        
        return NavigationView {
            SubjectListView()
        }
    }
}
