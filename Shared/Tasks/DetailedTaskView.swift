//
//  DetailedTaskView.swift
//  SchoolHelper
//
//  Created by Pradyun Setti on 11/01/21.
//

import SwiftUI

struct DetailedTaskView: View {
    var taskName: String
    var taskDesc: String
    
    var body: some View {
        Text(taskDesc)
            .font(.system(size: 18, weight: .medium, design: .default))
            .navigationBarTitle(taskName, displayMode: .inline)
    }
}

struct DetailedTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTaskView(taskName: "task name", taskDesc: "task description")
    }
}
