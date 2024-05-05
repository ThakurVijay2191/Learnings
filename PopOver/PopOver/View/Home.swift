//
//  Home.swift
//  PopOver
//
//  Created by Nap Works on 05/05/24.
//

import SwiftUI

struct Home: View {
    @State private var showPopOver: Bool = false
    @State private var updateText: Bool = false
    var body: some View {
        HStack {
//            Spacer()
            Button("Show Popover") {
                showPopOver.toggle()
            }
            .iOSPopover(isPresented: $showPopOver, arrowDirection: .up) {
                VStack(spacing: 12, content: {
                    HStack {
                        Spacer()
                        Button("Done") {
                            showPopOver.toggle()
                        }
                    }
                
                    ScrollView(.vertical) {
                        VStack(spacing: 15) {
                            ForEach(1...50, id: \.self){ index in
                                Text("This is list number \(index)")
                            }
                        }
                    }
                })
                .foregroundStyle(.white)
                .padding(15)
                .background{
                    Rectangle()
                        .fill(Color.black.gradient)
                        .padding(-20)
                }
//                .clipShape(.rect(cornerRadius: 40))
            }
        }
    }
}

#Preview {
    Home()
}

extension View {
    @ViewBuilder
    func iOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirection: UIPopoverArrowDirection, @ViewBuilder content: @escaping ()-> Content)-> some View {
        self
            .background{
                PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
            }
    }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    
    @State private var alreadyPresented: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if alreadyPresented {
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content> {
                hostingController.rootView = content
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            if !isPresented {
                uiViewController.dismiss(animated: true){
                    alreadyPresented = false
                }
            }
        }else {
            if isPresented {
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                controller.presentationController?.delegate = context.coordinator
                controller.popoverPresentationController?.sourceView = uiViewController.view
                uiViewController.present(controller, animated: true)
            }
        }
      
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopOverController
        init(parent: PopOverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: (any UIViewControllerTransitionCoordinator)?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
