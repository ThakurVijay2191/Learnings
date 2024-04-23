//
//  Home.swift
//  CanvasEdit
//
//  Created by Nap Works on 30/03/24.
//

import SwiftUI

struct Home: View {
    @StateObject var canvasModel: CanvasViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Canvas()
                .environmentObject(canvasModel)
            
            HStack (spacing: 15){
                Button(action: {}, label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                })
                
                Spacer()
                
                Button(action: {
                    canvasModel.showImagePicker.toggle()
                }, label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                })
            }
            .foregroundStyle(.white)
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            
            Button(action: {
                canvasModel.saveCanvasImage(height: 250) {
                    Canvas()
                        .environmentObject(canvasModel)
                }
            }, label: {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

        }
        .preferredColorScheme(.dark)
        .alert(canvasModel.errorMessage, isPresented: $canvasModel.showError) {
            
        }
        .sheet(isPresented: $canvasModel.showImagePicker, onDismiss: {
            if let image = UIImage(data: canvasModel.imageData) {
                canvasModel.addImageToStack(image: image)
            }
        }, content: {
            ImagePicker(showPicker: $canvasModel.showImagePicker, imageData: $canvasModel.imageData)
        })
    }
}

#Preview {
    Home()
}
