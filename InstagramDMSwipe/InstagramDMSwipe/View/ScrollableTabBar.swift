//
//  ScrollableTabBar.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 17/09/23.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    var content: Content
    var rect: CGRect
    @Binding var offset: CGFloat
    var tabs: [Any]
    
    let scrollview = UIScrollView()
    
    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: ()-> Content){
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        setupScrollView()
        
        scrollview.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        scrollview.contentOffset.x = offset
        scrollview.addSubview(extractView())
        scrollview.delegate = context.coordinator
        return scrollview
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset {
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
            } completion: { (status) in
                if status{ uiView.delegate = context.coordinator}
            }
        }
    }
    
    func setupScrollView(){
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
    }
    
    func extractView()-> UIView {
        let controller = UIHostingController(rootView: HStack(spacing: 0){content}.ignoresSafeArea())
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        return controller.view!
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollableTabBar
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
