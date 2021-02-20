//
//  Constants.swift
//  SchoolHelper (iOS)
//
//  Created by Pradyun Setti on 26/01/21.
//

import Foundation
import SwiftUI

struct Constants {
    static let darkModeGrey = Color(red: 64/255, green: 64/255, blue: 64/255)
    
    static let subjectColours = ["blue", "green", "red", "grey", "pink", "purple", "yellow", "orange"]
    static let colourDict = ["blue": Color.blue,
                      "green": Color.green,
                      "red": Color.red,
                      "grey": Color.gray,
                      "pink": Color.pink,
                      "purple": Color.purple,
                      "yellow": Color.yellow,
                      "orange": Color.orange
    ]
    
    static func MarkToGrade(_ mark: Int) -> String{
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
    
    static func DateToString(_ date: Date, format: String) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = format
        return(formatter1.string(from: date))
    }
    
    static func TodayAsString() -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "EEEE"
        return(formatter1.string(from: Date()))
    }
}

