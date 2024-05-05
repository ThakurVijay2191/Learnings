//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Nap Works on 02/03/24.
//

import SwiftUI
import AVKit


struct ContentView: View {
    
    @State private var url: String = "https://player.vimeo.com/external/450098966.sd.mp4?s=f0423e657e100a8d54d6aaa76f4bd2e144b72172&profile_id=164&oauth2_token_id=57447761"
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Video Url", text: $url)
                    .padding()
                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                    .padding()
                if let url: URL = .init(string: url) {
                    VideoPlayer(player: AVPlayer(url: url))
                        .aspectRatio(contentMode: .fit)
                }
               
            }
        }

    }
}

#Preview {
    ContentView()
}
