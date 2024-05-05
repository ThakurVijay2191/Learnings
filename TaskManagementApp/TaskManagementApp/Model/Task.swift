//
//  Task.swift
//  TaskManagementApp
//
//  Created by Nap Works on 13/11/23.
//

import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var taskTitle: String
    var creationDate: Date = .init()
    var isCompleted: Bool = false
    var tint: Color
    
}

var sampleTasks: [Task] = [
    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .taskColor1),
    .init(taskTitle: "Redesign Website", creationDate: .updateHour(-3), isCompleted: false, tint: .taskColor2),
    .init(taskTitle: "Go for a Walk", creationDate: .updateHour(-4), isCompleted: false, tint: .taskColor3),
    .init(taskTitle: "Edit Video", creationDate: .updateHour(0), isCompleted: true, tint: .taskColor4),
    .init(taskTitle: "Publish Video", creationDate: .updateHour(2), isCompleted: true, tint: .taskColor1),
    .init(taskTitle: "Tweet about new Video", creationDate: .updateHour(1), isCompleted: false, tint: .taskColor5),
]

extension Date {
    static func updateHour(_ value: Int)-> Date{
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
