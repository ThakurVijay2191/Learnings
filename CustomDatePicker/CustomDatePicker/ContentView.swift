//
//  ContentView.swift
//  CustomDatePicker
//
//  Created by Nap Works on 04/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showDatePicker: Bool = false
    @State private var date: Date = .now
    var body: some View {
        VStack {
            Button("Show Date Picker") {
                withAnimation(.linear(duration: 0.3)) {
                    showDatePicker = true
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
        }
        .datePicker(showDatePicker) {
            CustomDatePicker(style: .wheel,date: $date) {
                withAnimation(.linear(duration: 0.3)) {
                    showDatePicker = false
                }
            }
        }

    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func datePicker<Content: View>(_ isPresented: Bool, @ViewBuilder content: @escaping ()-> Content)-> some View {
        self
            .overlay {
                if isPresented {
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .ignoresSafeArea()
                }
            }
            .overlay {
                if isPresented {
                    content()
                        .transition(.move(edge: .bottom))
                }
            }
    }
}
