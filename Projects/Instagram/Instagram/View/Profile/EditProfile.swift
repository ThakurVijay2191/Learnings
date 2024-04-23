//
//  EditProfile.swift
//  Instagram
//
//  Created by Nap Works on 17/03/24.
//

import SwiftUI

struct EditProfile: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showEditProfile: Bool
    var body: some View {
        VStack(spacing: 0){
            Toolbar()
                .padding(.top, edges?.top)
                .padding(.top, 4)
            
            ScrollView {
                EditImageView()
            }
        }
        .lazyPop(isEnabled: .constant(true))
    }
    
    
    @ViewBuilder
    func Toolbar()->some View {
        VStack {
            HStack {
                Text("Edit profile")
                    .font(.system(size: 14, weight: .bold))
                    .hSpacing(.center)
                    .overlay(alignment: .leading) {
                        Button(action: {
                            withAnimation(.smooth(duration: 0.3)) {
                                showEditProfile = false
                            }
                        }, label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .medium))
                                .tint(.primary)
                        })
                    }
            }
            .padding(.top, 5)
            .padding(.horizontal)
            
            BorderView()
        }
    }
    
    @ViewBuilder
    func EditImageView()->some View {
        VStack (spacing: 12){
            Image("sajal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(.circle)
            
            Button("Edit picture or avatar") {
                
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.igSkyBlue)
            
            BorderView()
        }
        .padding(.top, 15)
    }
    
    
}

#Preview {
    EditProfile(showEditProfile: .constant(false))
}

struct BorderView: View {
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        Rectangle()
            .fill(scheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .frame(height: 1)
    }
}
