//
//  PresentationDetents.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 02/09/23.
//

import SwiftUI

struct PresentationDetents: View {
    @State private var showView: Bool = false
    var body: some View {
        Button("Show Sheet") {
            showView.toggle()
        }
        .sheet(isPresented: $showView) {
            Text("Hello from sheet")
                .presentationDetents([.small, .medium, .large])
                .presentationDragIndicator(.hidden)
        }
    }
}

//MARK: - Small custom detent
extension PresentationDetent {
    static let small = Self.height(100)
}

struct PresentationDetents_Previews: PreviewProvider {
    static var previews: some View {
        PresentationDetents()
    }
}
