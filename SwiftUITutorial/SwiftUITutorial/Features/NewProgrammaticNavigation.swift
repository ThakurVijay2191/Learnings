//
//  NewProgrammaticNavigation.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 16/09/23.
//

import SwiftUI

struct NewProgrammaticNavigation: View {
    //MARK: Creating Navigation Stack
    //Where you can push or pop views
    @State var mainStack: [NavigationType] = []
    var body: some View {
        NavigationStack (path: $mainStack){
            //Complex structure with tabview
            TabView {
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                
                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                Text("Notifications")
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                
                Text("Settings")
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                    }
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        mainStack.append(.dm)
                    }label: {
                        Image(systemName: "paperplane")
                            .font(.callout)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        mainStack.append(.camera)
                    }label: {
                        Image(systemName: "camera")
                            .font(.callout)
                    }
                }
            }
            //MARK: New API that can push new based on datatype
            .navigationDestination(for: NavigationType.self) { value in
                //MARK: Push your view based on value
                switch value {
                case .camera: VStack {
                    Text("Camera View")
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    
                    Button("Go to DM View") {
                        mainStack.append(.dm)
                    }
                }
                case .dm: VStack {
                    Text("DM View")
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    
                    Button("Pop To Root") {
                        mainStack.removeAll()
                    }
                }
                case .home: Text("Home View")
                }
            }
            
            
        }
    }
}

#Preview {
    NewProgrammaticNavigation()
}

//MARK: - Enum case for navigation stack item
enum NavigationType: String, Hashable {
    case dm = "DM VIEW"
    case camera = "CAMERA VIEW"
    case home = "HOME"
}
