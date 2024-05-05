//
//  Date+Extensions.swift
//  TaskManagementApp
//
//  Created by Nap Works on 13/11/23.
//

import SwiftUI

extension Date {
    func format(_ format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
