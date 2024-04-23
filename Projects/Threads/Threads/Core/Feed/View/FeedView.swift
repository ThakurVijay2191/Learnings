//
//  FeedView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(content: {
                    ForEach(1...10, id: \.self) { count in
                        ThreadCell()
                    }
                })
            })
            .refreshable {
                
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
