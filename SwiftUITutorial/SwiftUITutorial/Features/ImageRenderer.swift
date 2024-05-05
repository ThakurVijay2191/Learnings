//
//  ImageRenderer.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct ImageRendererTutorial: View {
    @State var generatedImage: UIImage?
    var body: some View {
        VStack {
            Button("Convert into Image") {
                let renderer = ImageRenderer(content: sampleView())
                if let image = renderer.uiImage {
                    generatedImage = image
                }
            }
            
            if let generatedImage = generatedImage {
                Image(uiImage: generatedImage)
            }
        }
    }
    
    @ViewBuilder
    func sampleView()-> some View {
        VStack {
            Image("Pic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("iJustine")
                .fontWeight(.black)
                .foregroundColor(.red)
        }
    }
}

struct ImageRendererTutorial_Previews: PreviewProvider {
    static var previews: some View {
        ImageRendererTutorial()
    }
}
