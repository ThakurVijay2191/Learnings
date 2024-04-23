//
//  ProfileView.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    @State private var showEditProfile: Bool = false
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Vijay Thakur")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("thakurvijay2191")
                                    .font(.subheadline)
                            }
                            
                            Text("I am a full time iOS Software Engineer")
                                .font(.footnote)
                            
                            Text("2 Followers")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        CircularProfileImageView()
                    }
                    
                    Button(action: {
                        showEditProfile.toggle()
                    }, label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(.black)
                            }
                        
                    })
                    
                    VStack {
                        HStack {
                            ForEach(ProfileThreadFilter.allCases){ filter in
                                VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                    
                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundStyle(.black)
                                            .frame(width: filterBarWidth, height: 1)
                                            .matchedGeometryEffect(id: "FILTER", in: animation)
                                    }else {
                                        Rectangle()
                                            .foregroundStyle(.clear)
                                        .frame(width: filterBarWidth, height: 1)                                }
                                    
                                }
                                .onTapGesture {
                                    withAnimation {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        
                        LazyVStack{
                            ForEach(0...10, id: \.self){ id in
                                ThreadCell()
                                    .padding(.horizontal, -16)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
                    .interactiveDismissDisabled()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }

                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
