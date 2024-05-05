//
//  ProfileView.swift
//  TourApp
//
//  Created by Nap Works on 19/04/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var user: UserModel?
    @State private var showAlert: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(attributedString)
                .font(.montserrat(.semibold, size: 20))
                .multilineTextAlignment(.center)
                .foregroundStyle(.darkBackground)
            
            Button(action: {
                self.showAlert = true
            }, label: {
                Text("Logout")
                    .font(.montserrat(.semibold, size: 18))
                    .foregroundStyle(.white)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(.orangeText, in: .capsule)
            })
        }
        .hSpacing()
        .vSpacing(.center)
        .padding(15)
        .background(.white)
        .alert(isPresented:$showAlert) {
            Alert(
                title: Text("Logout?"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .destructive(Text("Confirm")) {
                    CommonMethods.logout()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation(.easeInOut) {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                                windowScene.windows.first?.makeKeyAndVisible()
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            self.user = UserDefaultsMapper.getUser()
        }
    }
    
    var attributedString: AttributedString {
        var attributedString = AttributedString("You are currently logged in as \(user?.email ?? "")")
        guard let range = attributedString.range(of: user?.email ?? "") else {return ""}
        attributedString[range].foregroundColor = .orangeText
        
        return attributedString
    }
}

#Preview {
    ProfileView()
}
