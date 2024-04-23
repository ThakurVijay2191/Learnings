//
//  ContentView.swift
//  UnitTesting
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredAmount: String = ""
    @State private var tipAmount: Double = 0
    @State private var totalAmount: Double = 0
    @State private var tipSlider: Double = 15
    var body: some View {
        VStack (spacing: 40){
            VStack {
                Text("Enter Bill Amount")
                    .foregroundStyle(.secondary)
                TextField("0.00", text: $enteredAmount)
                    .font(.system(size: 70, weight: .semibold, design: .rounded))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .onChange(of: enteredAmount) { oldValue, newValue in
//                        guard let amount = Double(enteredAmount) else { return}
//                        guard let tip = Calculation().calculateTip(of: amount, with: tipSlider) else { return }
//                        tipAmount = tip
//                        totalAmount = amount + tipAmount
                    }
            }
            
            Text("Tip: \(tipSlider, specifier: "%.0f")%")
            
            Slider(value: $tipSlider, in: 0...100, step: 1)
                .onChange(of: tipSlider) { _, _ in
                    guard let amount = Double(enteredAmount) else { return}
                    guard let tip = Calculation().calculateTip(of: amount, with: tipSlider) else { return }
                    tipAmount = tip
                    totalAmount = amount + tipAmount
                    
                }
            
            VStack {
                Text(tipAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                
                Text("Tip")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            
            .padding(.top, 20)
            
            VStack {
                Text(totalAmount, format: .currency(code: "USD"))
                    .font(.title.bold())
                Text("Total")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .padding(30)
    }
}

#Preview {
    ContentView()
}

struct Calculation {
    func calculateTip(of enteredAmount: Double ,with tip: Double)-> Double? {
        guard enteredAmount >= 0 && tip >= 0 else { return nil}
        let tipPercentage = tip / 100
        return enteredAmount * tipPercentage
    }
}
