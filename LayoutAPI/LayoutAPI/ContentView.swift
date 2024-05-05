//
//  ContentView.swift
//  LayoutAPI
//
//  Created by Nap Works on 11/11/23.
//

import SwiftUI
import MyLibrary

struct ContentView: View {
    @State private var tags: [String] = [
        "Swift",
        "Objective-C",
        "iOS Development",
        "Xcode",
        "UIKit",
        "SwiftUI",
        "Core Data",
        "Cocoa Touch",
        "Interface Builder",
        "App Store",
        "iOS SDK",
        "Auto Layout",
        "Storyboards",
        "Push Notifications",
        "Core Animation",
        "Core Location",
        "ARKit",
        "Core ML",
        "In-App Purchases",
        "TestFlight"
    ]
                   
    
    @State private var selectedTags: [String] = []
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 0){
            ScrollView(.horizontal) {
                HStack(spacing: 12){
                    ForEach(selectedTags, id: \.self){ tag in
                        Text(tag)
                    }
                }
                .padding(.horizontal, 15)
                .frame(height: 35)
                .padding(.vertical, 15)
            }
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .overlay(content: {
                if selectedTags.isEmpty {
                    Text("Select more than 3 tags")
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            .background(.white)
            .zIndex(1)
            
            ConditionalNavigation(isActive: .constant(false)) {
                //go somewhere if condition passed
            }
            ScrollView(.vertical, content: {
                ChipLayout(alignment: .center, spacing: 10){
                    ForEach(tags + tags, id: \.self){ tag in
                        TagView(tag, .blue, "checkmark")
                    }
                }
                .padding(15)
            })
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .background(.black.opacity(0.05))
            .zIndex(0)
        
            ZStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.pink.gradient)
                        }
                })
                .disabled(selectedTags.count < 3)
                .opacity(selectedTags.count < 3 ? 0.5 : 1)
                .padding()
            }
            .background(.white)
            .zIndex(2)
        }
        .preferredColorScheme(.light)
        .onAppear{
            let double: Double = 1713707807
            let dateString = double.timestampToDateString("MMMM dd, yyyy hh:mm s")
            VTHelper.shared.showError("Sample", error: dateString)
        }
    }
    
    ///TAG View
    @ViewBuilder
    func TagView(_ tag: String, _ color: Color, _ icon: String)-> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
            Image(systemName: icon)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(color.gradient)
        }
    }
}
 
#Preview {
    ContentView()
}
