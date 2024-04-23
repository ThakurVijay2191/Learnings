//
//  KeyboardObserving.swift
//  TourApp
//
//  Created by Nap Works on 18/04/24.
//

import SwiftUI

struct KeyboardObserving: ViewModifier {

  var offset: CGFloat
  @State var keyboardHeight: CGFloat = 0
  @State var keyboardAnimationDuration: Double = 0

  func body(content: Content) -> some View {
    content
      .safeAreaPadding([.bottom], keyboardHeight)
      .edgesIgnoringSafeArea((keyboardHeight > 0) ? [.bottom] : [])
      .animation(.smooth(duration: keyboardAnimationDuration), value: keyboardHeight)
      .onReceive(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
          .receive(on: RunLoop.main),
        perform: updateKeyboardHeight
      )
  }

  func updateKeyboardHeight(_ notification: Notification) {
    guard let info = notification.userInfo else { return }
    // Get the duration of the keyboard animation
    keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)
      ?? 0.25

    guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
      else { return }
    // If the top of the frame is at the bottom of the screen, set the height to 0.
    if keyboardFrame.origin.y == UIScreen.main.bounds.height {
      keyboardHeight = 0
    } else {
      // IMPORTANT: This height will _include_ the SafeAreaInset height.
      keyboardHeight = keyboardFrame.height + offset
    }
  }
}
