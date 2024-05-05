//
//  ThreadCell.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct ThreadCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12, content: {
                CircularProfileImageView()
                
                VStack (alignment: .leading, spacing: 4){
                    HStack {
                        Text("thakurvijay2191")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        Spacer()
                           
                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }
                    
                    Text("this is a caption")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16){
                        Button(action: {}, label: {
                            Image(systemName: "heart")
                        })
                        
                        Button(action: {}, label: {
                            Image(systemName: "bubble.right")
                        })
                        
                        Button(action: {}, label: {
                            Image(systemName: "arrow.rectanglepath")
                        })
                        
                        Button(action: {}, label: {
                            Image(systemName: "paperplane")
                        })
                        
                    }
                    .tint(.black)
                    .padding(.top, 8)
                }
            })
            .padding()
            
            Divider()
        }
    }
}

#Preview {
    ThreadCell()
}
