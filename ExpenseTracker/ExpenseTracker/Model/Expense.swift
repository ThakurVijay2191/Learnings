//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Nap Works on 10/09/23.
//

import SwiftUI
import SwiftData

@Model
class Expense {
    var title: String
    var subtitle: String
    var amount: Double
    var date: Date
    var category: Category?
   
    init(title: String, subtitle: String, amount: Double, date: Date, category: Category? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.date = date
        self.category = category
    }
    
    @Transient
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(for: amount) ?? ""
    }
    
}


