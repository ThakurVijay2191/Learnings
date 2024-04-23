//
//  UserCell.swift
//  Threads
//
//  Created by Nap Works on 24/09/23.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            CircularProfileImageView()
            
            VStack(alignment: .leading) {
                Text("thakurvijay2191")
                    .fontWeight(.semibold)
                Text("Vijay Thakur")
            }
            .font(.footnote)
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 6)
                    .foregroundStyle(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                
            })
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell()
}
