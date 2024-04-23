//
//  Detail.swift
//  AppleWatchStoreUI
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct Detail: View {
    @State private var text: String = ""
    var detailData: Watch = data[0]
    
    var body: some View {
        ZStack {
            Color("Color")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    })
                }
                .padding(.vertical)
                HStack(spacing: 15, content: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundStyle(.gray)
                    TextField("Want to search anything?", text: $text)
                })
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                HStack {
                    VStack(alignment: .leading, spacing: 10, content: {
                        Text(self.detailData.title)
                        Text("Apple Watch Series 5")
                            .font(.title.bold())
                    })
                    .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding()
                Spacer()
                //MARK: - 13:55
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    Detail()
}
