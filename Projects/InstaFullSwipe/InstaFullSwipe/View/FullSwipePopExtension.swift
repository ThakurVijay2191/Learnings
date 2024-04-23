//
//  FullSwipePopExtension.swift
//  InstaFullSwipe
//
//  Created by Nap Works on 24/03/24.
//

import SwiftUI

extension View {
    func  fullSwipePop<Content: View>(show: Binding<Bool>, content: @escaping ()->Content)->some View{
        return FullSwipePopHelper(mainContent: self, content: content(), show: show)
    }
}

#Preview {
    ContentView()
}

private struct FullSwipePopHelper<MainContent: View, Content: View>: View {
    var mainContent: MainContent
    var content: Content
    @Binding var show: Bool
    
    init(mainContent: MainContent, content: Content, show: Binding<Bool>) {
        self.mainContent = mainContent
        self.content = content
        self._show = show
    }
    
    @GestureState private var gestureOffset: CGFloat = 0
    @State private var offset: CGFloat = 0
    
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader{ proxy in
            mainContent
                .offset(x: (show && offset >= 0) ? getOffset(size: proxy.size.width) : 0)
                .overlay {
                    ZStack {
                        if show {
                            content
                                .background {
                                    (scheme == .dark ? Color.black : Color.white)
                                        .shadow(radius: 1.3)
                                        .ignoresSafeArea()

                                }
                                .offset(x: offset > 0 ? offset : 0)
                                .gesture(
                                    DragGesture()
                                        .updating($gestureOffset, body: { value, out, _ in
                                            out = value.translation.width
                                        })
                                        .onEnded({ value in
                                            withAnimation(.linear.speed(2)){
                                                offset = 0
                                                
                                                let translation = value.translation.width
                                                
                                                let maxTranslation = proxy.size.width / 1.9
                                                
                                                if translation > maxTranslation {
                                                    show = false
                                                }
                                            }
                                        })
                                )
                                .transition(.move(edge: .trailing))
                        }
                    }
                }
                .onChange(of: gestureOffset) { oldValue, newValue in
                    offset = gestureOffset
                }
        }
        
    }
    
    func getOffset(size: CGFloat)->CGFloat{
        let progress = offset / size
        
        let start: CGFloat = -80
        
        let progressWidth = (progress * 90) <= 90 ? (progress * 90) : 90
        
        let mainOffset = (start + progressWidth) < 0 ? (start + progressWidth) : 0
        
        return mainOffset
    }
}
