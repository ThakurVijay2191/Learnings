//
//  Home.swift
//  TabSlider
//
//  Created by Nap Works on 17/02/24.
//

import SwiftUI

struct Home: View {
    @State var offset: CGFloat = 0
    @State var currentTab: Tab = sampleTabs.first!
    @State var isTapped: Bool = false
    @StateObject var gestureManager: InteractionManager = .init()
    var body: some View {
        GeometryReader { proxy in
            let screenSize = proxy.size
            
            ZStack (alignment: .top){
                
                TabView(selection: $currentTab){
                    ForEach(sampleTabs){ tab in
                        GeometryReader{ proxy in
                            let size = proxy.size
                            Image(tab.sampleImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipped()
                        }
                        .ignoresSafeArea()
                        .offsetX { value  in
                            if currentTab == tab && !isTapped{
                                offset = value - (screenSize.width * CGFloat(indexOf(tab: tab)))
                            }
                            
                            if value == 0 && isTapped {
                                 isTapped = false
                            }
                            
                            if isTapped && gestureManager.isInteracting {
                                isTapped = false
                            }
                        }
                        .tag(tab)
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onAppear(perform: gestureManager.addGesture)
                .onDisappear(perform: gestureManager.removeGesture)
                
                DynamicTabHeader(size: screenSize)
                
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
        .onChange(of: gestureManager.isInteracting) { newValue in
            
        }
    }
    
    @ViewBuilder
    func DynamicTabHeader(size: CGSize)->some View {
        VStack(alignment: .leading, spacing: 22, content: {
             Text("Dynamic Tabs")
                .font(.title.bold())
                .foregroundStyle(.white)
            
            HStack (spacing: 0){
                ForEach(sampleTabs) { tab in
                    Text(tab.tabName)
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
            }
            .overlay(alignment: .leading) {
                Capsule()
                    .fill(.white)
                    .overlay(alignment: .leading, content: {
                        GeometryReader{ _ in
                            HStack (spacing: 0){
                                ForEach(sampleTabs) { tab in
                                    Text(tab.tabName)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 6)
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity)
                                        .contentShape(.capsule)
                                        .onTapGesture {
                                            isTapped = true
                                            withAnimation(.easeInOut) {
                                                currentTab = tab
                                                offset = -(size.width) * CGFloat(indexOf(tab: tab))
                                            }
                                        }
                                }
                            }
                            .offset(x: -tabOffset(size: size, padding: 30))

                         }
                        .frame(width: size.width - 30)
                    })
                    .frame(width: (size.width - 30) / CGFloat(sampleTabs.count))
                    .mask {
                        Capsule()
                    }
                    .offset(x: tabOffset(size: size, padding: 30))
            }
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea()
        }
    }
    
    func tabOffset(size: CGSize, padding: CGFloat)->CGFloat{
        return (-offset / size.width) * ((size.width - padding) / CGFloat(sampleTabs.count))
    }
    
    func indexOf(tab: Tab)->Int {
        let index = sampleTabs.firstIndex { CTab in
            CTab == tab
        } ?? 0
        
        return index
    }

}

#Preview {
    ContentView()
}

class InteractionManager: NSObject, ObservableObject,UIGestureRecognizerDelegate{
    @Published var isInteracting: Bool = false
    @Published var isGestureAdded: Bool = false
    
    func addGesture(){
        if !isGestureAdded {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(onChange(gesture: )))
            gesture.name = "UNIVERSAL"
            gesture.delegate = self
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let window = windowScene.windows.last?.rootViewController else { return }
            
            window.view.addGestureRecognizer(gesture)
            isGestureAdded = true
        }
    }
    
    func removeGesture(){
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = windowScene.windows.last?.rootViewController else { return }
        
        window.view.gestureRecognizers?.removeAll(where: { gesture in
            return gesture.name == "UNIVERSAL"
        })
        isGestureAdded = false
    }
    
    @objc
    func onChange(gesture: UIPanGestureRecognizer) {
        isInteracting = (gesture.state == .changed)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
