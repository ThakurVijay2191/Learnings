//
//  View.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

extension View{
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center)-> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center)-> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func keyboardObserving(offset: CGFloat = 0.0) -> some View {
      self.modifier(KeyboardObserving(offset: offset))
    }
    
    @ViewBuilder
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    var safeArea: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero}
        return windowScene.keyWindow?.safeAreaInsets ?? .zero
    }
    
    func hapticImpact(){
        let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
        impactHeavy.impactOccurred()
    }
}
