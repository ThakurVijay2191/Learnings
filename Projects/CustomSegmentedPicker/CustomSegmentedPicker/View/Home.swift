//
//  Home.swift
//  CustomSegmentedPicker
//
//  Created by Nap Works on 02/10/23.
//

import SwiftUI

struct Home: View {
    @State private var currentTab: String = "Incomings"
    @Namespace var animation
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image("menu")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.white)
                    
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image("dashboard")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.white)
                    
                })
                
            }
            .padding()
            
            Text("Statistics")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            HStack {
                Text("Incomings")
                    .fontWeight(.bold)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 25)
                    .background {
                        ZStack {
                            if currentTab == "Incomings"{
                                Color.white
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .matchedGeometryEffect(id: "TAG", in: animation)
                            }
                        }
                    }
                    .foregroundStyle(currentTab == "Incomings" ? .black : .white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Incomings"
                        }
                    }
                
                Text("Outgoings")
                    .fontWeight(.bold)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 25)
                    .background {
                        ZStack {
                            if currentTab == "Outgoings"{
                                Color.white
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .matchedGeometryEffect(id: "TAG", in: animation)
                            }
                        }
                    }
                    .foregroundStyle(currentTab == "Outgoings" ? .black : .white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Outgoings"
                        }
                    }

            }
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(Color.black.opacity(0.35))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 20)
            
            HStack(spacing: 37) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 22)
                    Circle()
                        .trim(from: 0, to: 0.6)
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                    
                    Image(systemName: "dollarsign.square.fill")
                        .font(.system(size: 55, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: 180)
                
                VStack (alignment: .leading, spacing: 10){
                    
                    Text("Spent")
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.6))
                    Text("$190")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    
                    Text("Maximum")
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.top, 10)
                    Text("$500")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 30)
            .padding(.vertical, 30)
            
            VStack {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 100, height: 2)
                
                HStack(spacing: 15) {
                    VStack (alignment: .leading, spacing: 10){
                        Text("Your Balance")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(.black)
                        
                        Text("May 1, 2021")
                            .font(.caption.bold())
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                    .offset(x: -10)

                }
                .padding(.top, 8)
         
                HStack {
                    Text("$22,306.07")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "arrow.up")
                        .foregroundStyle(.gray)
                    Text("14%")
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
        
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(
                Color.white
                    .clipShape(CustomShape(corners: [.topLeft, .topRight], radius: 35))
                    .ignoresSafeArea(.all, edges: .bottom)
            )

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg").ignoresSafeArea())
    }
}

#Preview {
    Home()
}
