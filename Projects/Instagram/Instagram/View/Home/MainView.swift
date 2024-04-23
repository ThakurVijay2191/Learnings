//
//  MainView.swift
//  Instagram
//
//  Created by Nap Works on 07/01/24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) private var scheme
    @State private var allTabs: [TabModel] = [
        .init(inActiveImage: "house", activeImage: "house.fill", type: .home),
        .init(inActiveImage: "search", activeImage: "search.fill", type: .search),
        .init(inActiveImage: "plus", activeImage: "plus", type: .plus),
        .init(inActiveImage: "reel", activeImage: "reel.fill", type: .reel),
        .init(inActiveImage: "sample", activeImage: "sample", isProfile: true, type: .profile),
    ]
    @Binding var activeTab: TabModel
    @Binding var offset: CGFloat
    @Binding var isPlusClicked: Bool
    @State private var isDark: Bool = false
    @State private var isTabHidden: Bool = false
    @State private var mainStack: [MainNavigation] = []
    @State private var homeStack: [HomeNavigation] = []
    @State private var profileStack: [ProfileNavigation] = []
    @State private var showEditProfile: Bool = false
    init(activeTab: Binding<TabModel>, offset: Binding<CGFloat>, isPlusClicked: Binding<Bool>) {
        UITabBar.appearance().isHidden = true
        self._activeTab = activeTab
        self._offset = offset
        self._isPlusClicked = isPlusClicked
    }
    
    var body: some View {
        VStack(spacing: 0){
            TabView (selection: $activeTab){
                Home(offset: $offset)
                    .tag(allTabs[0])
                
                SearchView()
                .tag(allTabs[1])
        
                NavigationStack {
                    ReelMainView()
                }
                .tag(allTabs[3])
                
                Profile(isTabHidden: $isTabHidden, showEditProfile: $showEditProfile)
                    .tag(allTabs[4])
            }
            .tabViewStyle(.automatic)

            //custom tab bar
            HStack(spacing: 0){
                ForEach(allTabs){ tab in
                    
                    Image(activeTab.type == tab.type ? tab.activeImage : tab.inActiveImage)
                        .resizable()
                        .renderingMode(tab.isProfile ? .original : .template)
                        .aspectRatio(contentMode: tab.isProfile ? .fill : .fit)
                        .frame(width: 25, height: 25)
                        .hSpacing()
                        .foregroundStyle((isDark || scheme == .dark) ? .white : .black)
                        .clipShape(tab.isProfile ? AnyShape(.circle) : AnyShape(.rect))
                        .contentShape(tab.isProfile ? AnyShape(.circle) : AnyShape(.rect))
                        .onTapGesture {
                            if tab.type == .plus {
                                offset = 0
                                self.isPlusClicked = true
                            }else {
                                activeTab = tab
                                self.isPlusClicked = false
                            }
                        }
                }
            }
            .tint(.white)
            .padding(.top, 12)
            .padding(.horizontal, 10)
            .padding(.bottom, edges?.bottom)
            .background((isDark || scheme == .dark) ? .black : .white)
            .overlay(alignment: .top) {
                Divider()
            }
            
        }
        .onChange(of: activeTab, initial: false, { oldValue, newValue in
            if activeTab.id == allTabs[3].id {
                //tapped on reels
                self.isDark = true
            }else {
                self.isDark = false
            }
        })
        .fullSwipePop(show: $showEditProfile) {
            EditProfile(showEditProfile: $showEditProfile)
        }
    }
    
}

#Preview {
    MainTabView()
}

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

struct TabModel: Identifiable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var inActiveImage: String
    var activeImage: String
    var isProfile: Bool = false
    var type: TabModelType
}

enum TabModelType {
    case home
    case search
    case plus
    case reel
    case profile
}
