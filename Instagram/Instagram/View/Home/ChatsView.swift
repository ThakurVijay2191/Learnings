//
//  ChatsView.swift
//  Instagram
//
//  Created by Nap Works on 24/03/24.
//

import SwiftUI


struct ChatsView: View {
    @State private var search: String = ""
    @Binding var offset: CGFloat
    @State private var tabs: [String] = ["Primary", "General", "Channels", "Requests"]
    @State private var activeTab: String = "Primary"
    @State private var offsetY: CGFloat = 0
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ToolBarView()
                    .padding(.top, edges?.top)
                  
                ScrollView {
                    VStack {
                        SearchBar()
                        NotesListView()
                        TabBarView()
                        ChatListView()
                    }
                    .background(GeometryReader {
                        Color.clear
                            .preference(key: ViewOffsetKey.self,
                                   value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        self.offsetY = $0
                        print("offset >> \($0)")
                    }
                }
                .coordinateSpace(name: "scroll")
                
            }
        }
    }
    
    /// top header view
    @ViewBuilder
    func ToolBarView()->some View {
        HStack {
            Button(action: {
                offset = rect.width
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 25, weight: .regular))
            })
            .padding(.leading)
            Button(action: {}, label: {
                HStack(spacing: 6){
                    Text("i_am_thakur_vijay")
                        .font(.system(size: 24, weight: .bold))
                    Image(systemName: "chevron.right")
                        .font(.callout)
                        .fontWeight(.medium)
                        .rotationEffect(.init(degrees: 90))
                    Circle()
                        .fill(.igRed)
                        .frame(width: 8, height: 8)
                }
                .hSpacing(.leading)
            })
            
            HStack (spacing: 15){
                Button(action: {}, label: {
                    Image("dot_horizontal")
                        .IconModifier(size: .init(width: 25, height: 25))
                })
                
                Button(action: {}, label: {
                    Image("pencil_edit")
                        .IconModifier(size: .init(width: 20, height: 20))
                })
                
            }
            .padding(.trailing)
        }
        .tint(.primary)
        .padding(.bottom, 10)
        .animation(.easeInOut, value: offsetY >= 10)
        .overlay(alignment: .bottom) {
            if self.offsetY >= 10 {
                Divider()
            }
        }
        
    }
    
    /// Search bar
    @ViewBuilder
    func SearchBar()->some View {
        HStack (spacing: 15){
            HStack(spacing: 8){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .regular))
                Text("Search")
                    .font(.system(size: 18, weight: .regular))
            }
            .foregroundStyle(.igSecondaryText)
            .hSpacing(.leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.igLight, in: .rect(cornerRadius: 10, style: .continuous))
            Button(action: {}, label: {
                Text("Filter")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.igSkyBlue)
            })
        }
        .padding(.horizontal)
        .padding(.top, 10)

    }
    
    /// chat cell view
    @ViewBuilder
    func ChatListView()->some View {
        LazyVStack(spacing: 16) {
            ForEach(1...10, id: \.self){ _ in
               ChatCardView()
            }
        }
        .padding(.vertical, 12)
    }
    
    /// chat card view
    @ViewBuilder
    func ChatCardView()->some View {
        HStack (spacing: 12){
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(.igSecondaryText, lineWidth: 0.4)
                }
            
            VStack (alignment: .leading, spacing: 4){
                Text("Thakur Vijay")
                    .font(.system(size: 14, weight: .regular))
                
                Text("Seen 21m ago")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            .hSpacing(.leading)
            
            
            Circle()
                .fill(.igSkyBlue)
                .frame(width: 8, height: 8)
            Button {
                
            } label: {
                Image("camera")
                    .IconModifier(size: .init(width: 20, height: 20), renderingMode: .template)
                    .foregroundStyle(.black)
                    .padding(.leading, 8)
            }

        }
        .padding(.horizontal)
    }
    
    /// notes list view
    @ViewBuilder
    func NotesListView()->some View {
        HStack {
            AddNoteView()
        }
    }
    
    /// add note view
    @ViewBuilder
    func AddNoteView()->some View {
        VStack {
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(.circle)
            
            Text("Your note")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 35)
        .overlay(alignment: .top) {
            Text("Note...")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .background(.white.shadow(.drop(color: .black.opacity(0.15), radius: 15, x: 0, y: 0)), in: .rect(cornerRadius: 15))
                .overlay(alignment: .bottomLeading) {
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .scaleEffect(1.3)
                        .offset(x: 15, y: 3)
                    
                }
        }
        .padding(.top, 10)
        .hSpacing(.leading)
        .padding(.horizontal)
    }
    
    /// Tab Bar View
    @ViewBuilder
    func TabBarView()->some View {
        HStack (spacing: 8){
            ForEach(tabs, id: \.self){ tab in
                Button(action: {
                    activeTab = tab
                }, label: {
                    HStack (spacing: 6){
                        Circle()
                            .fill(.igSkyBlue)
                            .frame(width: 6, height: 6)
                        Text(tab + (tab == "Primary" ? " 1" : ""))
                    }
                    .hSpacing(.center)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.vertical, 8)
                    .foregroundStyle(activeTab == tab ? .igSkyBlue : .primary)
                    .background(activeTab == tab ? .igLightSkyBlue : .igLight, in: .rect(cornerRadius: 8))
                })
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    ChatsView(offset: .constant(0))
}

var rect = UIScreen.main.bounds
let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
var edges = windowScene?.windows.first?.safeAreaInsets

