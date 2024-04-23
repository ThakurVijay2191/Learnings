//
//  ContentView.swift
//  FullSwipeBack
//
//  Created by Nap Works on 17/02/24.
//

import SwiftUI

struct ContentView: View {
   
    @State private var texts: [String] = Array(repeating: "", count: 100)
    var body: some View {
        FullSwipeNavigationStack {
            List {
                Section("Sample Header") {
                    NavigationLink("Full Swipe View"){
                        View1()
                            .navigationBarBackButtonHidden()
                            .enableFullSwipePop(true)
                    }
                    
                }
            }
            .navigationTitle("Full Swipe Pop")
        }
    }
}

#Preview {
    ContentView()
}

struct View1: View {
    var body: some View {
        VStack {
            NavigationLink("Go to secondView"){
                View2()
                    .navigationBarBackButtonHidden()
                    .enableFullSwipePop(true)

            }
           
        }
    }
}


struct View2: View {
    @State private var isEnabled: Bool = false
    var body: some View {
        VStack {
            NavigationLink("Go to third view"){
                View3()
                    .navigationBarBackButtonHidden()
                    .enableFullSwipePop(true)

            }
        }
    }
}

struct View3: View {
    var body: some View {
        List {
           Text("Full Swipe View")
                .navigationBarBackButtonHidden()
        }
//        .enableFullSwipePop(true)
        .navigationTitle("Full Swipe View")
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
