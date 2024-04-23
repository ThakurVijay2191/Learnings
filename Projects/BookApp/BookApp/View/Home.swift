//
//  Home.swift
//  BookApp
//
//  Created by Nap Works on 07/01/24.
//

import SwiftUI

struct Home: View {
    @State private var activeTag: String = "Biography"
    @State private var carouselMode: Bool = false
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Browse")
                    .font(.largeTitle.bold())
                
                Text("Recommended")
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                    .foregroundStyle(.gray)
                    .offset(y: 2)
                
                Spacer(minLength: 10)
                
                Menu {
                    Button("Toggle Carousel Mode (\(carouselMode ? "On" : "Off"))") {
                        carouselMode.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.init(degrees: -90))
                        .foregroundStyle(.gray)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            TagsView()
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.vertical) {
                    ///Books Card View
                    VStack (spacing: 35){
                        ForEach(sampleBooks) {
                            BookCardView($0)
                         }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .padding(.bottom, bottomPadding(size))
                    .background {
                        ScrollViewDetector(carouselMode: $carouselMode,
                                           totalCardCount: sampleBooks.count)
                    }
                }
                .scrollIndicators(.hidden)
                .coordinateSpace(name: "SCROLLVIEW")
            }
            .padding(.top, 15)
        }
    }
    
    /// bottom padding for last card to move upto the top
    func bottomPadding(_ size: CGSize = .zero)-> CGFloat{
        let cardHeight: CGFloat = 220
        let scrollViewHeight: CGFloat = size.height
        
        return scrollViewHeight - cardHeight - 40
    }
    
    /// Book Card View
    @ViewBuilder
    func BookCardView(_ book : Book)-> some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
    
            HStack(spacing: -25, content: {
                ///Book Detail Card
                VStack(alignment: .leading, spacing: 6, content: {
                    Text(book.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("By \(book.author)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    ///Rating View
                    RatingView(rating: book.rating)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4, content: {
                        Text("\(book.bookViews)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        
                        Text("Views")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    })
                })
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                }
                .zIndex(1)
                
                
                ///Book Cover Image
                ZStack {
                    Image(book.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width / 2, height: size.height)
                        .clipShape(.rect(cornerRadius: 10, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: -5, y: -5)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .frame(width: size.width)
            .rotation3DEffect(
                .init(degrees: convertOffsetToRotation(rect)),
                axis: (x: 1, y: 0, z: 0),
                anchor: .bottom,
                anchorZ: 1,
                perspective: 0.8
            )
        }
        .frame(height: 220)
    }
    
    
    /// Converting MinY to rotation
    func convertOffsetToRotation(_ rect: CGRect)-> CGFloat{
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
       
        return constrainedProgress * 90
    }
    
    /// Tags View
    @ViewBuilder
    func TagsView()-> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10, content: {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background {
                            if activeTag == tag {
                                Capsule()
                                    .fill(Color("CustomBlue"))
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }else {
                                Capsule()
                                    .fill(.gray.opacity(0.2))
                            }
                        }
                        .foregroundStyle(activeTag == tag ? .white : .gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag = tag
                            }
                        }
                }
            })
            .padding(.horizontal, 15)
        }
        .scrollIndicators(.hidden)
    }
}

var tags: [String] = [
    "History", "Classical", "Biography", "Cartoon", "Adventure", "Fairy tales", "Fantasy"
]

#Preview {
    ContentView()
}

///Custom Rating View
struct RatingView: View {
    var rating: Int
    var body: some View {
        HStack(spacing: 4, content: {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundStyle(index <= rating ? .yellow : .gray.opacity(0.5))
            }
            
            Text("(\(rating))")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.yellow)
                .padding(.leading, 5)
        })
    }
}

/// ScrollView Detector
struct ScrollViewDetector: UIViewRepresentable {
    @Binding var carouselMode: Bool
    var totalCardCount: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView , context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.decelerationRate = carouselMode ? .fast : .normal
                if carouselMode {
                    scrollView.delegate = context.coordinator
                }else {
                    scrollView.delegate = nil
                }
                context.coordinator.totalCount = totalCardCount
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewDetector
        
        init(parent: ScrollViewDetector) {
            self.parent = parent
        }
        
        var totalCount: Int = 0
        var velocityY: CGFloat = 0

        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            ///Removing Invalid Scroll Position's
            let cardHeight: CGFloat = 220
            let cardSpacing: CGFloat = 35
            ///Adding Velocity for more natural feel
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocity.y * 60)
            let index = (targetEnd / cardHeight).rounded()
            let modifiedEnd = index * cardHeight
            let spacing = cardSpacing * index
            targetContentOffset.pointee.y = modifiedEnd + spacing
            velocityY = velocity.y
        }
        
        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            ///Removing Invalid Scroll Position's
            let cardHeight: CGFloat = 220
            let cardSpacing: CGFloat = 35
            ///Adding Velocity for more natural feel
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocityY * 60)
            let index = max(min((targetEnd / cardHeight).rounded(), CGFloat(totalCount - 1)), 0.0)
            let modifiedEnd = index * cardHeight
            let spacing = cardSpacing * index
            
            scrollView.setContentOffset(.init(x: 0, y: modifiedEnd + spacing), animated: true)
        }
    }
}
