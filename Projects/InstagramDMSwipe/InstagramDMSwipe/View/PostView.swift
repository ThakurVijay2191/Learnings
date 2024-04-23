//
//  PostView.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 17/09/23.
//

import SwiftUI

struct PostView: View {
    @Binding var offset: CGFloat
    var body: some View {
        ZStack {
            
            Color.black
            VStack {
               
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "gear")
                            .font(.title)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        offset = rect.width
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    })
                }
                .foregroundStyle(.white)
                .padding()
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "photo")
                        .font(.title)
                })
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding(.top, edges?.top ?? 15)
            .padding(.bottom, edges?.bottom)
        }
    }
}

#Preview {
    MainView()
}
