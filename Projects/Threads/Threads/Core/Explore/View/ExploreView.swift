//
//  ExploreView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack {
                    ForEach(0...10, id: \.self) { id in
                        VStack {
                            UserCell()
                            Divider()
                             .padding(.vertical, 4)
                        }
                    }
                }
            })
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Search")
        }
    }
}

#Preview {
    ExploreView()
}
