//
//  FeedView.swift
//  InstagramDMSwipe
//
//  Created by Nap Works on 17/09/23.
//

import SwiftUI

struct FeedView: View {
    @Binding var offset: CGFloat
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "plus.app")
                        .font(.title)
                        .foregroundColor(.primary)
                })
                
                Spacer()
                
                Button(action: {
                    offset = rect.width * 2
                }, label: {
                    Image(systemName: "paperplane")
                        .font(.title)
                        .foregroundColor(.primary)
                })
            }
            .padding()
            .overlay(
                Text("Instagram")
                    .font(.title2)
                    .fontWeight(.bold)
            )
            
            ScrollView {
                ScrollView(.horizontal) {
                    HStack(spacing: 15, content: {
                        Button(action: {}, label: {
                            Image("profile1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                        .background(Color.white.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/))
                                        .offset(x: 8, y: 5)
                                    , alignment: .bottomTrailing
                                )
                        })
                           
                    })
                    .padding()
                }
                
                
                Divider()
                    .padding(.horizontal, -15)
                
                VStack(spacing: 0) {
                    ForEach(posts.indices, id: \.self) { index in
                        PostCardView(post: posts[index], index: index, count: posts.count)
                    }
                }
                .padding(.bottom)
            }

        }
    }
}

struct PostCardView: View {
    var post: Post
    var index: Int
    var count: Int
    @State var comment: String = ""
    var body: some View {
        VStack(spacing: 15){
            HStack (spacing: 15){
                Image(post.profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Text(post.user)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                        .rotationEffect(.init(degrees: 90))
                })
            }
            .zIndex(2)
            Image(post.postImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: rect.width - 20, height: 300)
                .cornerRadius(15)
            
            HStack (spacing: 15){
                Button(action: {}, label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 25))
                })
                
                Button(action: {}, label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                })
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 25))
                })
            }
            .foregroundStyle(.primary)
            
            (
                Text("\(post.user) ")
                    .fontWeight(.bold)
                
                +
                
                Text(post.postTitle)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(6)
            
            HStack(spacing: 15) {
                Image("profile1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                TextField("Add a comment...", text: $comment)
            }
        
            Text(post.time)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 6)
            
            if index != count - 1 {
                Divider()
                    .padding(.horizontal, -15)
            }
           
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
    }
}
