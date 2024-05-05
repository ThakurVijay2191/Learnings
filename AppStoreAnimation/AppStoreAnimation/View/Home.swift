//
//  Home.swift
//  AppStoreAnimation
//
//  Created by Nap Works on 27/04/24.
//

import SwiftUI

struct Home: View {
    ///Animation Properties
    @State private var currentItem: Today?
    @State private var showDetailPage: Bool = false
    
    ///Matched Geometry Effect
    @Namespace private var animation
    
    ///Detail Animation Properties
    @State private var animateView: Bool = false
    @State private var animateContent: Bool = false
    @State private var scrollOffset: CGFloat = 0
    var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 0){
                HStack(alignment: .bottom) {
                    VStack (alignment: .leading, spacing: 8){
                        Text("MONDAY 4 APRIL")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        Text("Today")
                            .font(.largeTitle.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {}, label: {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    })
                }
                .padding(.horizontal)
                .padding(.bottom)
                .opacity(showDetailPage ? 0 : 1)
                
                ForEach(todayItems){ item in
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                             currentItem = item
                             showDetailPage = true
                        }
                    }, label: {
                        CardView(item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.94)
                            .contentShape(.rect)
                    })
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
        .overlay {
            if let currentItem, showDetailPage {
                DetailView(currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.BG)
                .frame(height: animateView ? nil : 350, alignment: .top)
                .scaleEffect(animateView ? 1 : 0.93)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    
    ///Card View
    @ViewBuilder
    func CardView(_ item: Today)-> some View {
        VStack (alignment: .leading, spacing: 15){
            ZStack(alignment: .topLeading) {
                //banner image
                GeometryReader{ proxy in
                    let size = proxy.size
                    Image(item.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 400)
                
                LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }
                .tint(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea.top : 0)
            }
            
            HStack(spacing: 12, content: {
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 15, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Text(item.appName)
                        .fontWeight(.bold)
                    Text(item.appDescription)
                        .font(.caption)
                        .foregroundStyle(.gray)
                })
                .tint(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {}, label: {
                    Text("GET")
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background {
                            Capsule()
                                .fill(.ultraThinMaterial)
                        }
                })
            })
            .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.BG)
        }
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    ///Detail View
    @ViewBuilder
    func DetailView(_ item: Today)-> some View {
        ScrollView(.vertical) {
            VStack {
                CardView(item)
                    .scaleEffect(animateView ? 1 : 0.93)
                
                VStack (spacing: 15){
                    ///dummy text
                    Text(dummyText)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)
                    
                    Divider()
                    
                    Button(action: {}, label: {
                        Label {
                            Text("Share Story")
                        } icon: {
                            Image(systemName: "square.and.arrow.up.fill")
                        }
                        .foregroundStyle(.primary)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.ultraThinMaterial)
                        }
                    })
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateContent ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topTrailing, content: {
            Button(action: {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage = false
                }
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            })
            .padding()
            .padding(.top, safeArea.top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
        }
        .transition(.identity)

    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


///Safe Area Value
extension View {
    var safeArea: UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
    
    ///Scrollview offset
    func offset(offset: Binding<CGFloat>)-> some View {
        return self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    offset.wrappedValue = value
                })
            }
    }
}


struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
