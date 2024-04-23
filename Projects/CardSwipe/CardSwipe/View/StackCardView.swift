//
//  StackCardView.swift
//  CardSwipe
//
//  Created by Nap Works on 11/11/23.
//

import SwiftUI

struct StackCardView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var user: User
    
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(homeData.getIndex(user: user))
            
            let bottomOffset = (index <= 2 ? index : 2) * 20
            
            ZStack {
                Image(user.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - bottomOffset, height: size.height)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
                    .shadow(color: .red.opacity(0.3), radius: 15.0, x:1, y: 1)
                    .offset(y: bottomOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 10)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
        .gesture(
          DragGesture()
            .updating($isDragging, body: { value, out, _ in
                out = true
            })
            .onChanged({ value in
                let translation = value.translation.width
                offset = (isDragging ? translation : 0)
            })
            .onEnded({ value in
                let width = getRect().width - 50
                let translation = value.translation.width
                let checkingStatus = (translation > 0 ? translation : -translation)
                 
                withAnimation {
                    if checkingStatus > (width / 2) {
                        //remove card
                        offset = (translation > 0 ? width : -width) * 2
                        endSwipeActions()
                        
                        if translation > 0 {
                            rightSwipe()
                        }else {
                            leftSwipe()
                        }
                        
                    }else {
                        //reset
                        offset = .zero
                    }
                }
            })
        )
        //receiving notifications posted
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)){ data in
            guard let info = data.userInfo else { return }
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = getRect().width - 50
            if user.id == id {
                withAnimation {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    }else {
                        leftSwipe()
                    }
                    
                }
            }
            
        }
    }
    
    //Rotation
    func getRotation(angle: Double)->Double{
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }

    func endSwipeActions(){
        withAnimation (.none) {endSwipe = true}
        
        //After the card is moved away, removing the card from array to preserve the memory...
        //The delay time based on your animation duration...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            if let _ = homeData.displaying_users?.first {
                let _ = withAnimation {
                    homeData.displaying_users?.removeFirst()
                }
            }
        }
    }
    
    func leftSwipe(){
        print("Left Swiped")
    }
    
    func rightSwipe(){
        print("Right Swiped")
    }
}

#Preview {
    ContentView()
}

extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
