//
//  Home.swift
//  InstagramStory
//
//  Created by Nap Works on 24/02/24.
//

import SwiftUI

struct Home: View {
    @StateObject var storyData = StoryViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
               
                ScrollView(.horizontal) {
                    HStack (spacing: 12){
                        Button(action: {}, label: {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                                .overlay(alignment: .bottomTrailing ){
                                    Image(systemName: "plus")
                                        .padding(7)
                                        .background(.blue, in: .circle)
                                        .foregroundStyle(.white )
                                        .padding(2)
                                        .background(.black, in: .circle)
                                        .offset(x: 10, y: 10)
                                }
                        })
                        .padding(.trailing, 10)
                        
                        ForEach($storyData.stories){ $bundle in
                            ProfileView(bundle: $bundle)
                                .environmentObject(storyData)
                        }
                    }
                    .padding()
                    .padding(.top, 10)
                }
                .scrollIndicators(.hidden)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Instagram")
        }
//        .fullScreenCover(isPresented: $storyData.showStory, content: {
//            StoryView()
//                .environmentObject(storyData)
//        })
        .overlay {
            StoryView()
                .environmentObject(storyData)
        }
    }
}

#Preview {
    ContentView()
}

struct ProfileView: View {
    @EnvironmentObject var storyData: StoryViewModel
    @Binding var bundle: StoryBundle
    @Environment(\.colorScheme) var scheme
    var body: some View {
        Image(bundle.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .padding(2)
            .background(scheme == .dark ? .black : .white, in: .circle)
            .padding(3)
            .background {
                LinearGradient.init(
                    colors: [
                        .red,
                        .orange,
                        .red,
                        .orange
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(.circle)
                .opacity(bundle.isSeen ? 0 : 1)
            }
            .onTapGesture {
                withAnimation {
                    
                    bundle.isSeen = true
                    storyData.currentStory = bundle.id
                    storyData.showStory = true
                    
                }
            }
    }
}
