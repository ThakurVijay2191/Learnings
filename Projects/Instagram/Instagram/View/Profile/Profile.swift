//
//  Profile.swift
//  Instagram
//
//  Created by Nap Works on 03/03/24.
//

import SwiftUI

struct Profile: View {
    @Binding var isTabHidden: Bool
    @State private var selectedTab: ProfileStep?
    @State private var tabProgress: CGFloat = 0
    @State private var show: Bool = false
    
    @State private var profileStack: [ProfileNavigation] = []
    @Binding var showEditProfile: Bool

    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack(path: $profileStack) {
            GeometryReader { reader in
                VStack {
                    HeaderView()
                        .padding(.top, edges?.top)
                        .padding(.top, 4)
                    
                    ScrollView {
                        VStack{
                            UserInfoView()
                            
                            ProfessionDashboardView()
                            
                            ActionButtonsView()
                            
                            ReelsContainerView(reader.size)
                        }
                    }
                }

            }
            .lazyPop(isEnabled: .constant(true))
            .onAppear{
                isTabHidden = false
            }
            .navigationDestination(for: ProfileNavigation.self) { value in
                switch value {
                case .professionalDashboard:
                    ProfessionDashboard()
                }
            }
           
        }
    }
    
    @ViewBuilder
    func HeaderView()-> some View {
        HStack {
            HStack(spacing: 4){
                Text("sample_user")
                    .font(.system(size: 22, weight: .bold))
                Image("chevron")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .rotationEffect(.init(degrees: 180))
                Circle()
                    .fill(.igRed)
                    .frame(width: 8, height: 8)
            }
            .hSpacing(.leading)
            
            HStack (spacing: 25){
                Image("plus")
                    .IconModifier(size: .init(width: 22, height: 22),contentMode: .fit,renderingMode: .template)
            
                Image("menu")
                    .IconModifier(size: .init(width: 22, height: 22),contentMode: .fit,renderingMode: .template)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    func UserInfoView()-> some View {
        VStack {
            HStack {
                UserImage(image: "sample", size: .init(width: 85, height: 85))
                
                HStack {
                    RecordView("Posts", count: 17)
                    RecordView("Followers", count: 39)
                    RecordView("Following", count: 147)
                }
                .hSpacing(.center)
                .padding(.horizontal)
                
            }
            
            VStack {
                Text("Sample User")
                    .font(.system(size: 16, weight: .semibold))
                    .hSpacing(.leading)
                Text("Your conversations are processed by human reviewers to improve the technologies powering Gemini Apps. Don’t enter anything you wouldn’t want reviewed or used.")
                    .font(.system(size: 14, weight: .regular))
                    .hSpacing(.leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 0)
    }
    
    @ViewBuilder
    func RecordView(_ title: String, count: Int)->some View {
        VStack {
            Text("\(count)")
                .font(.system(size: 16, weight: .bold))
            
            Text(title)
                .font(.system(size: 14, weight: .regular))
        }
        .hSpacing(.center)
    }
    
    @ViewBuilder
    func ProfessionDashboardView()-> some View {
        Button {
            profileStack.append(.professionalDashboard)
        } label: {
            VStack (alignment: .leading){
                Text("Professional dashboard")
                    .font(.system(size: 14, weight: .bold))
                Text("46 accounts reached in the last 30 days.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.igSecondaryText)
                    .multilineTextAlignment(.leading)
            }
            .hSpacing(.leading)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.igSecondaryButtonBackground, in: .rect(cornerRadius: 5, style: .continuous))
            .padding(.horizontal)
        }

    }
    
    @ViewBuilder
    func ActionButtonsView()-> some View {
        HStack(spacing: 8){
            Button(action: {
                withAnimation(.smooth(duration: 0.25)){
                    showEditProfile.toggle()
                }
//                mainStack.append(.editProfile)
            }, label: {
                Text("Edit profile")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 8)
                    .background(.igSecondaryButtonBackground, in: .rect(cornerRadius: 5, style: .continuous))

            })
            
            Button(action: {}, label: {
                Text("Share profile")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 8)
                    .background(.igSecondaryButtonBackground, in: .rect(cornerRadius: 5, style: .continuous))
            })
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func CustomTabBar()-> some View {
        HStack(spacing: 0){
            ForEach(ProfileStep.allCases, id: \.rawValue){ tab in
                HStack(spacing: 10){
                    Image(tab.rawValue)
                        .IconModifier(size: .init(width: 25, height: 25), contentMode: .fit, renderingMode: .template)
                }
                .hSpacing(.center)
                .padding(.vertical, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress)
        .background{
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(ProfileStep.allCases.count)
                Rectangle()
                    .fill(.primary)
                    .frame(width: capsuleWidth, height: 1)
                    .vSpacing(.bottom)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .overlay(alignment: .bottom, content: {
            Divider()
        })
//        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    func SampleView(color: Color)-> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
            ForEach(1...10, id: \.self) { id in
                RoundedRectangle(cornerRadius: 15)
                    .fill(color.gradient)
                    .frame(height: 150)
                    .overlay {
                        VStack(alignment: .leading){
                            Circle()
                                .fill(.white.opacity(0.25))
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 6){
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.white.opacity(0.25))
                                    .frame(width: 80, height: 8)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.white.opacity(0.25))
                                    .frame(width: 60, height: 8)
                            }
                            
                            Spacer(minLength: 0)
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.white.opacity(0.25))
                                .frame(width: 40, height: 8)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }
        })

    }
    
    @ViewBuilder
    func AllPostsGridView(width: CGFloat)-> some View{
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3),spacing: 0.1, content: {
            ForEach(1...30, id: \.self) { id in
                GeometryReader{reader in
//                    Image("sample")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: reader.size.width, height: reader.size.height)
                }
                .frame(width: width/3, height: (width/3) * 1)
                .background(.red)
                .clipped()
                .overlay(alignment: .topTrailing) {
                    Image("reel.fill")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .symbolVariant(.fill)
                        .padding([.top, .trailing], 10)
                        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
                }

                
            }
        })
    }
    
    @ViewBuilder
    func AllReelsGridView(width: CGFloat)-> some View{
        ZStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3),alignment: .center,spacing: 0.1, content: {
                ForEach(1...30, id: \.self) { id in
                    GeometryReader{ reader in
//                        Image("sample")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: reader.size.width, height: reader.size.height)
                            
                    }
                    .frame(width: width/3, height: (width/3) * 1.77777777778)
                    .background(.green)
                    .clipped()
                    .overlay(alignment: .topTrailing) {
                        Image("reel.fill")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)
                            .symbolVariant(.fill)
                            .padding([.top, .trailing], 10)
                            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
                    }
                }
            })

        }
    }
    
    @ViewBuilder
    func ReelsContainerView(_ size: CGSize)->some View {
        VStack(spacing: 2){
            CustomTabBar()
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0){
//                    SampleView(color: .blue)
//                        .id(ProfileStep.allPosts)
//                        .containerRelativeFrame(.horizontal)
//                    SampleView(color: .green)
//                        .id(ProfileStep.reels)
//                        .containerRelativeFrame(.horizontal)
//                    SampleView(color: .red)
//                        .id(ProfileStep.taggedReels)
//                        .containerRelativeFrame(.horizontal)
                    AllPostsGridView(width: size.width)
                        .id(ProfileStep.allPosts)
                        .containerRelativeFrame(.horizontal)
                    
                    AllReelsGridView(width: size.width)
                        .id(ProfileStep.reels)
                        .containerRelativeFrame(.horizontal)
                    
                    SampleView(color: .blue)
                        .id(ProfileStep.taggedReels)
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
                .offsetX { value in
                    print(value)
                    let progress = -value / (size.width * CGFloat(ProfileStep.allCases.count - 1))
                    print(progress)
                    if progress.isNaN{
                        tabProgress = 0
                    }else {
                        tabProgress = progress
                    }
                }
            }
            .scrollPosition(id: $selectedTab)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .scrollClipDisabled()
        }
    }
}

#Preview {
    Profile(isTabHidden: .constant(false), showEditProfile: .constant(false))
}

extension Image {
    func IconModifier(size: CGSize, contentMode: ContentMode = .fit, renderingMode: Image.TemplateRenderingMode = .original) -> some View {
        self
            .resizable()
            .renderingMode(renderingMode)
            .aspectRatio(contentMode: contentMode)
            .frame(width: size.width, height: size.height)
   }
}

struct UserImage: View {
    var image: String
    var size: CGSize
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipShape(.circle)
    }
}

enum ProfileStep: String, CaseIterable {
    case allPosts = "grid"
    case reels = "reel"
    case taggedReels = "person_square"
}

//Offset Key
struct CustomOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat)->())-> some View{
        self
            .overlay {
                GeometryReader {
                    let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                    
                    Color.clear
                        .preference(key: CustomOffsetKey.self, value: minX)
                        .onPreferenceChange(CustomOffsetKey.self, perform: completion)
                }
            }
    }
    
    //Tab bar Masking
    @ViewBuilder
    func tabMask(_ tabProgress: CGFloat)-> some View {
        ZStack {
            self
                .foregroundStyle(.igSecondaryText)
            
            self
                .symbolVariant(.fill)
                .mask {
                    GeometryReader {
                        let size = $0.size
                        let capsuleWidth = size.width / CGFloat(ProfileStep.allCases.count)
                        Rectangle()
                            .frame(width: capsuleWidth)
                            .offset(x: tabProgress * (size.width - capsuleWidth))
                    }
                }
        }
    }
}


