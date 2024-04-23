//
//  Home.swift
//  CardSwipe
//
//  Created by Nap Works on 11/11/23.
//

import SwiftUI

struct Home: View {
    @StateObject private var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        VStack {
            //Top Nav Bar
            Button(action: {}, label: {
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                Text("Discover")
                    .font(.title.bold())
            }
            .foregroundStyle(.white)
            .padding()
            
            ZStack {
                if let users = homeData.displaying_users {
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }else {
                        ForEach(users.reversed()) { user in
                            StackCardView(user: user)
                                .environmentObject(homeData)
                        }
                    }
                }else {
                    ProgressView()
                }
            }
            .padding(.bottom, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //Action Buttons
            
            HStack(spacing: 15){
                Button(action: {}, label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                })
                
                Button(action: {
                    doSwipe(rightSwipe: true)
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                })
                
                Button(action: {}, label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.yellow)
                        .clipShape(Circle())
                })
                
                Button(action: {
                    doSwipe()
                }, label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Pink"))
                        .clipShape(Circle())
                })
            }
            .padding(.bottom)
            .disabled(homeData.displaying_users?.isEmpty ?? false)
            .opacity(homeData.displaying_users?.isEmpty ?? false ? 0.5 : 1.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BackgroundColor"))
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = homeData.displaying_users?.first else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}
 
#Preview {
    Home()
}
