//
//  Home.swift
//  TaskManagementApp
//
//  Created by Nap Works on 13/11/23.
//

import SwiftUI

struct Home: View {
    @State private var currentDate: Date = .init()
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HeaderView()
        }
        .vSpacing(.top)
    }
    
    //Header View
    @ViewBuilder
    func HeaderView()-> some View{
        VStack(alignment: .leading, spacing: 6){
            HStack(spacing: 5){
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.darkBlue)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing){
            Button {
                
            } label: {
                Image(.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }

        }
        .padding(15)
        .background(.white)
       
    }
}

#Preview {
    ContentView()
}
