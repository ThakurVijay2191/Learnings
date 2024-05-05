//
//  Home.swift
//  InstaFullSwipe
//
//  Created by Nap Works on 24/03/24.
//

import SwiftUI

struct Home: View {
    @State var show: Bool = false
    @State var currentDay: Int = 1
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(1...15, id: \.self){ index in
                        Button(action: {
                            withAnimation {
                                currentDay = index
                                show.toggle()
                            }
                        }, label: {
                            Text("Day \(index) of SwiftUI")
                        })
                        .foregroundStyle(.primary)
                    }
                } header: {
                    Text("Tutorials")
                }

            }
            .listStyle(.insetGrouped  )
            .navigationTitle("Full Swipe Pop ")
        }
        .fullSwipePop(show: $show) {
            NavigationStack {
                List {
                    Section {
                        ForEach(1...30, id: \.self){ index in
                            Button(action: {
                                withAnimation {
                                    show = false
                                }
                            }, label: {
                                Text("Course \(index)")
                            })
                            .foregroundStyle(.primary)
                        }
                    } header: {
                        Text("Tutorials")
                    }

                }
                .listStyle(.insetGrouped  )
                .navigationTitle("Day \(currentDay) of SwiftUI")
            }
        }
    }
}

#Preview {
    ContentView()
}
