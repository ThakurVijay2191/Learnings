//
//  ContentView.swift
//  DarkModeAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI
import VTFrameworks

struct ContentView: View {
    @State private var activeTab: Int = 0
    ///Sample Toggle States
    @State private var toggles: [Bool] = Array(repeating: false, count: 10)
    ///Interface Style
    @AppStorage("toggleDarkMode") private var toggleDarkMode: Bool = false
    @AppStorage("activeDarkMode") private var activeDarkMode: Bool = false
    @State private var buttonRect: CGRect = .zero
    ///Current And Previous State Images
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false

    var body: some View {
        ///Sample view
        TabView(selection: $activeTab) {
            NavigationStack {
                List {
                    Section("Text Section") {
                        Toggle("Large Display", isOn: $toggles[0])
                        Toggle("Bold Text", isOn: $toggles[1])
                    }
                    
                    Section {
                        Toggle("Night Light", isOn: $toggles[2])
                        Toggle("True Tone", isOn: $toggles[3])
                    } header: {
                        Text("Display Section")
                    } footer: {
                        Text("This is a sample footer.")
                    }

                }
                .navigationTitle("Dark Mode")
            }
            .tag(0)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            Text("Settings")
                .tag(1)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .createImages(toggleDarkMode: toggleDarkMode, currentImage: $currentImage, previousImage: $previousImage, activateDarkMode: $activeDarkMode)
        .overlay(content: {
            GeometryReader(content: { geometry in
                let size = geometry.size
                if let previousImage, let currentImage {
                    ZStack {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading) {
                                Circle()
                                    .frame(width: buttonRect.width * (maskAnimation ? 80 : 1), height: buttonRect.height * (maskAnimation ? 80 : 1), alignment: .bottomLeading)
                                    .frame(width: buttonRect.width, height: buttonRect.height)
                                    .offset(x: buttonRect.minX, y: buttonRect.minY)
                                    .ignoresSafeArea()
                            }
                    }
                    .task {
                        guard !maskAnimation else { return }
                        withAnimation(.easeIn(duration: 0.9), completionCriteria: .logicallyComplete) {
                            maskAnimation = true
                        } completion: {
                            self.currentImage = nil
                            self.previousImage = nil
                            maskAnimation = false
                        }

                    }
                }
            })
            .mask({
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        Circle()
                            .frame(width: buttonRect.width, height: buttonRect.height)
                            .offset(x: buttonRect.minX, y: buttonRect.minY)
                            .blendMode(.destinationOut)
                    }
            })
            .ignoresSafeArea()
        })
        .overlay(alignment: .topTrailing) {
            Button(action: {toggleDarkMode.toggle()}, label: {
                Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .tint(.primary)
                    .symbolEffect(.bounce, value: toggleDarkMode)
                    .frame(width: 40, height: 40)
            })
            .rect { rect in
                buttonRect = rect
            }
            .padding(10)
            .disabled(currentImage != nil || previousImage != nil || maskAnimation)
            
        }
        .preferredColorScheme(activeDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
