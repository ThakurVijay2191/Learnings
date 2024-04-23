//
//  ReelView.swift
//  ReelsLayout
//
//  Created by Nap Works on 06/01/24.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likedCounter: [Like]
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State private var player: AVPlayer?
    @State private var looper: AVPlayerLooper?
    
    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            
            CustomVideoPlayer(player: $player)
                .preference(key: OffsetKey.self, value: rect)
                .onPreferenceChange(OffsetKey.self, perform: { value in
                   playPause(value)
                })
                .overlay(alignment: .bottom, content: {
                    ReelDetailsView()
                })
                .onTapGesture(count: 2, perform: { position in
                      let id = UUID()
                    likedCounter.append(.init(id: id, tappedRect: position, isAnimated: false))
                    
                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
                        if let index = likedCounter.firstIndex(where: { $0.id == id}) {
                            likedCounter[index].isAnimated = true
                        }
                    } completion: {
                        likedCounter.removeAll(where: { $0.id == id}) 
                    }

                    reel.isLiked = true
                })
                .onAppear{
                    guard player == nil else { return }
                    guard let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else { return }
                    let videoURL = URL(filePath: bundleID)
                    let playerItem = AVPlayerItem(url: videoURL)
                    let queue = AVQueuePlayer(playerItem: playerItem)
                    looper = AVPlayerLooper(player: queue, templateItem: playerItem)
                    
                    player = queue
                    playPause(rect)
                    
                }
                .onDisappear {
                    player?.pause()
                    player = nil
                }
        }
    }
    
    func playPause(_ rect: CGRect){
        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5){
            player?.play()
        }else {
            player?.pause()
        }
        
        if rect.minY >= size.height || -rect.minY >= size.height {
            player?.seek(to: .zero)
        }
    }
    
    @ViewBuilder
    func ReelDetailsView()-> some View {
        HStack(alignment: .bottom, spacing: 10){
            VStack(alignment: .leading, spacing: 8, content: {
                HStack(spacing: 10, content: {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                })
                .foregroundStyle(.white)
                
                Text("Lorem Ipsume is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            })
            
            Spacer(minLength: 0)
            
            ///Controls View
            VStack(spacing: 35, content: {
                Button("", systemImage: reel.isLiked ? "suit.heart.fill" : "suit.heart") {
                    reel.isLiked.toggle()
                }
                .symbolEffect(.bounce, value: reel.isLiked)
                .foregroundStyle(reel.isLiked ? .red : .white)
                
                Button("", systemImage: "message") {}
                
                Button("", systemImage: "paperplane") {}
                
                Button("", systemImage: "ellipsis") {}
            })
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, safeArea.bottom + 15)
    }
}


#Preview {
    ContentView()
}


struct CustomReelPlayer: View {
    @State private var player: AVPlayer?
    @State private var looper: AVPlayerLooper?
    var reel: String
    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            
            CustomVideoPlayer(player: $player)
                .onAppear{
                    guard player == nil else { 
                        player?.isMuted = true
                        player?.play()
                        return
                    }
                    guard let bundleID = Bundle.main.path(forResource: reel, ofType: "mp4") else { return }
                    let videoURL = URL(filePath: bundleID)
                    let playerItem = AVPlayerItem(url: videoURL)
                    let queue = AVQueuePlayer(playerItem: playerItem)
                    looper = AVPlayerLooper(player: queue, templateItem: playerItem)
                    
                    player = queue
                    player?.isMuted = true
                    player?.play()
                    
                }
                .onDisappear {
                    player?.pause()
                }
        }
    }
    
//    func playPause(_ rect: CGRect){
//        if -rect.minY < (rect.height * 0.5) && rect.minY < (rect.height * 0.5){
//            player?.play()
//        }else {
//            player?.pause()
//        }
//        
//    }
}
