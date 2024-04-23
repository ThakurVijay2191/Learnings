//
//  ThreadCreationView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct ThreadCreationView: View {
    @State private var caption: String = ""
    @Binding var showCreateThreadView: Bool
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top){
                    CircularProfileImageView()
                    VStack(alignment: .leading, spacing: 4){
                        Text("thakurvijay2191")
                            .fontWeight(.semibold)
                        
                        TextField("Start a thread...", text: $caption, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button(action: {
                            caption = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.gray)
                        })
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showCreateThreadView = false
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
