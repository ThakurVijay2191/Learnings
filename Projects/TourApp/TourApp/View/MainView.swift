//
//  MainView.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct MainView: View {
    @State private var currentTab: Tab = .explore
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack (spacing: 0){
            TabView (selection: $currentTab){
                ExploreView()
                    .tag(Tab.explore)
                Text("Map")
                    .tag(Tab.map)

                Text("My Tour")
                    .tag(Tab.myTour)

                ProfileView()
                    .tag(Tab.profile)

            }
            
            ///custom tab bar
            CustomTabBar()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    @ViewBuilder
    func CustomTabBar()-> some View {
        HStack (spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){ tab in
                Button(action: {
                    withAnimation(.interactiveSpring) {
                        currentTab = tab
                    }
                }, label: {
                    VStack {
                        Image(tab.image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .hSpacing()
                            .foregroundStyle(currentTab == tab ? .orangeText : .darkBackground)
                        
                        Text(tab.rawValue)
                            .font(.montserrat(currentTab == tab ? .semibold : .regular, size: 14))
                            .foregroundStyle(currentTab == tab ? .orangeText : .darkBackground)
                    }
                })
                .buttonStyle(StaticButtonStyle())
            }
        }
        .padding(.top, 15)
        .background(.lightBackground)
    }
}

#Preview {
    MainView()
}
