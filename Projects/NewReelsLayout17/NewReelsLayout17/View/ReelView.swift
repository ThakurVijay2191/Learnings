//
//  ReelView.swift
//  NewReelsLayout17
//
//  Created by Nap Works on 18/11/23.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likedCounter: [Like]
    var size : CGSize
    var safeArea: EdgeInsets
    
    @State private var player: AVPlayer?
    var body: some View {
        GeometryReader {_ in
            CustomVideoPlayer(player: $player)
                .overlay(alignment: .bottom, content: {
                    ReelDetailView()
                })
                .onAppear(perform: {
                    guard player == nil else { return }
                    guard let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else { return }
                    let videoURL = URL(filePath: bundleID)
                    player = AVPlayer(url: videoURL)
                })
                .onDisappear(perform: {
                    player = nil
                })
        }
    }
    
    @ViewBuilder
    func ReelDetailView()-> some View {
        HStack(alignment: .bottom,spacing: 10){
            VStack(alignment: .leading, spacing: 8){
                HStack(spacing: 10){
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            }
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    ContentView()
}
