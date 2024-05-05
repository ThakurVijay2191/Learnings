//
//  CanvasViewModel.swift
//  CanvasEdit
//
//  Created by Nap Works on 30/03/24.
//

import SwiftUI

class CanvasViewModel: NSObject, ObservableObject {
    @Published var stack: [StackItem] = []
    
    @Published var showImagePicker: Bool = false
    @Published var imageData: Data = .init(count: 0)
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var currentlyTappedItem: StackItem?
    @Published var showDeleteAlert: Bool = false
    
    func addImageToStack(image: UIImage) {
        let imageView = Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
        
        stack.append(.init(view: AnyView(imageView )))
    }
    
    func saveCanvasImage<Content: View>(height: CGFloat, @ViewBuilder content: @escaping ()->Content){
        let uiView = UIHostingController(rootView: content().padding(.top, -safeArea().top))
        let frame = CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: height))
        uiView.view.frame = frame
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        uiView.view.drawHierarchy(in: frame, afterScreenUpdates: true)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let newImage {
           writeToAlbum(image: newImage)
        }
    }
    
    func writeToAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletion(_:didFinishSavingWithError: contextInfo:)), nil)
    }
    
    @objc
    func saveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error {
            self.errorMessage = error.localizedDescription
            self.showError.toggle()
        }else {
            self.errorMessage = "Saved Successfully!"
            self.showError.toggle()
        }
    }
    
    func safeArea()->UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero}
        return safeArea
    }
}
