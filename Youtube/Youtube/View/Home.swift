//
//  Home.swift
//  Youtube
//
//  Created by Nap Works on 04/05/24.
//

import SwiftUI

struct Home: View {
    @State private var activeTab: Tab = .home
    @State private var config: PlayerConfig = .init()
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $activeTab){
                HomeTabView()
                    .setupTab(.home)
                Text(Tab.shorts.rawValue)
                    .setupTab(.shorts)
                Text(Tab.subscriptions.rawValue)
                    .setupTab(.subscriptions)
                Text(Tab.you.rawValue)
                    .setupTab(.you)
            }
            .padding(.bottom, tabBarHeight)
            
            ///Mini Player View
            GeometryReader {
                let size = $0.size
                if config.showMiniPlayer {
                    MiniPlayerView(size: size,config: $config){
                        withAnimation(.easeInOut(duration: 0.3), completionCriteria: .logicallyComplete) {
                            config.showMiniPlayer = false
                        } completion: {
                            config.resetPosition()
                            config.selectedPlayerItem = nil
                        }

                    }
                }
            }
            
            CustomTabBar()
                .offset(y: config.showMiniPlayer ? tabBarHeight - (config.progress * tabBarHeight) : 0)

        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    ///Home Tab View
    @ViewBuilder
    func HomeTabView()-> some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 15) {
                    ForEach(items){ item in
                        PlayerItemCardView(item){
                            config.selectedPlayerItem = item
                            withAnimation(.easeInOut(duration: 0.3)) {
                                config.showMiniPlayer = true
                            }
                        }
                    }
                }
                .padding(15)
            }
            .navigationTitle("Youtube")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.background, for: .navigationBar)
        }
    }
    
    ///Player Item Card View
    @ViewBuilder
    func PlayerItemCardView(_ item: PlayerItem, onTap: @escaping ()->())-> some View {
        VStack(alignment: .leading, spacing: 6){
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect)
                .onTapGesture(perform: onTap)
            
            HStack(spacing: 10){
                Image(systemName: "person.circle.fill")
                    .font(.title)
                
                VStack(alignment: .leading, spacing: 4){
                    Text(item.title)
                        .font(.callout)
                    
                    HStack(spacing: 6){
                        Text(item.author)
                        Text("· 2 Days Ago")
                    }
                    .font(.caption)
                    .foregroundStyle(.gray)
                }
            }
        }
    }
    
    ///Custom Tab Bar
    @ViewBuilder
    func CustomTabBar()-> some View {
        HStack (spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){ tab in
                VStack (spacing: 4){
                    Image(systemName: tab.symbol)
                        .font(.title3)
                    Text(tab.rawValue)
                        .font(.caption2)
                }
                .foregroundStyle(activeTab == tab ? Color.primary : .gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(.rect)
                .onTapGesture {
                    activeTab = tab
                }
            }
        }
        .frame(height: 49)
        .overlay(alignment: .top){
            Divider()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(height: tabBarHeight)
        .background(.background)
    }
    
   
}

///View Extensions
extension View {
    @ViewBuilder
    func setupTab(_ tab: Tab)-> some View {
        self
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    var tabBarHeight: CGFloat {
        return 49 + safeArea.bottom
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
