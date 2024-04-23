//
//  ContentView.swift
//  GlassMorphism
//
//  Created by Nap Works on 09/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

#Preview {
    ContentView()
}

struct Home: View {
    let attributedString = AttributedString("Please check terms and conditions")
    let termsRange: Range<AttributedString.Index>
    
    init() {
        if let range = attributedString.range(of: "terms and conditions") {
            termsRange = range
        } else {
            termsRange = attributedString.startIndex..<attributedString.endIndex
        }
    }
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.BG_1, Color.BG_2],
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            GeometryReader {proxy in
                let size = proxy.size
                Color.black.opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                Circle()
                    .fill(Color("Purple"))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: -size.width/1.9, y: -size.height/5)
                
                Circle()
                    .fill(Color("LightBlue"))
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: size.width/1.9, y: -size.height / 5)
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: size.width/1.8, y: size.height / 2)
                
                Circle()
                    .fill(Color("Purple"))
                    .padding(100)
                    .blur(radius: 110)
                    .offset(x: -size.width/1.8, y: size.height / 2)
                
            }
            
            VStack {
                Spacer(minLength: 10)
                
                ZStack {
                    Circle()
                        .fill(Color("Purple"))
                        .blur(radius: 20 )
                        .frame(width: 100, height: 100)
                        .offset(x: 120, y: -80)
                    
                    Circle()
                        .fill(Color.lightBlue)
                        .blur(radius: 40 )
                        .frame(width: 100, height: 100)
                        .offset(x: -120, y: 100)
                    GlassMorphicCard()

                }

                Spacer(minLength: 10)
                
                Text("Know Everything\nabout the weather")
                    .font(.system(size: 40, weight: .bold))
                
                Text(getAttributedString())
                    .fontWeight(.semibold)
                    .kerning(1.1)
                    .padding(.top, 10)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Get Started")
                        .font(.title3.bold())
                        .padding(.vertical, 22)
                        .frame(maxWidth: .infinity)
                        .background (
                            LinearGradient(
                                colors: [.button1, .button2],
                                startPoint: .leading,
                                endPoint: .trailing), in: .rect(cornerRadius: 20)
                        )
                })
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                
                Button(action: {}, label: {
                    Text("Already have an account?")
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                })
                .padding(.bottom)
            }
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .padding()
        }
        
    }

    func getAttributedString()-> AttributedString{
        var attStr = AttributedString("Start now and learn more about \n local weather instantly")
        attStr.foregroundColor = .gray
        
        if let range = attStr.range(of: "local weather"){
            attStr[range].foregroundColor = .white
        }
        return attStr
    }
}

struct GlassMorphicCard: View {
    let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(
                                .init(colors: [
                                    Color("Purple"),
                                    Color("Purple").opacity(0.5),
                                    .clear,
                                    .clear,
                                    Color(.lightBlue)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                            lineWidth: 2.5
                        )
                        .padding(2)
                )
                .shadow(color: .black.opacity(0.1), radius: 5 , x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5 , x: 5, y: 5)
            
            VStack {
                Image(systemName: "sun.max")
                    .font(.system(size: 75, weight: .thin))
                Text("18")
                    .font(.system(size: 85, weight: .bold ))
                    .padding(.top, 2)
                    .overlay(
                       Text("°C")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.7))
                        .offset(x: 30, y: 15)
                       , alignment: .topTrailing
                    )
                    .offset(x: -6)
                
                Text("Cracow, Poland")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.4))

            }
        }
        .frame(width: width / 1.7, height: 270)
    }
}
