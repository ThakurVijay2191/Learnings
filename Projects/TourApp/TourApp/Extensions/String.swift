//
//  String.swift
//  BaggedBySteven-iOS
//
//  Created by Akash on 17/04/23.
//

import Foundation
extension String{
    func trimAndCheckIsEmpty() -> Bool{
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func trim() -> String{
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trimSpace() -> String{
        return trimmingCharacters(in: .whitespaces)
    }
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    var initials: String {
        return self.components(separatedBy: " ")
            .reduce("") {
                ($0.isEmpty ? "" : "\($0.first?.uppercased() ?? "")") +
                ($1.isEmpty ? "" : "\($1.first?.uppercased() ?? "")")
            }
    }
    
    func capitalizedFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var slashDateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        } else {
            return ""
        }
    }
    
    var hyphenFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        } else {
            return ""
        }
    }
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
    
    var convertDateFormat: String{
        let inputFormat = "yyyy-MM-dd"
        let outputFormat = "MMM dd, yyyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return ""
        }
    }  
    
    var convertToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: self) {
           return date
        } else {
            return .init()
        }
    }
 
    var extractDatePart: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"
            let datePart = outputDateFormatter.string(from: date)
            
            return datePart
        } else {
            return ""
        }
    }
}
