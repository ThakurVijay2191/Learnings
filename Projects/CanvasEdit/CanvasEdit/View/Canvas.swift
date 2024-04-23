//
//  Canvas.swift
//  CanvasEdit
//
//  Created by Nap Works on 30/03/24.
//

import SwiftUI

struct Canvas: View {
    @EnvironmentObject var canvasModel: CanvasViewModel
    var height: CGFloat = 250
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                Color.white
                
                ForEach($canvasModel.stack){ $stackItem in
                    CanvasSubView(stackItem: $stackItem) {
                        stackItem.view
                    } moveFront: {
                        moveViewToFront(stackItem: stackItem)
                    } onDelete: {
                        canvasModel.currentlyTappedItem = stackItem
                        canvasModel.showDeleteAlert.toggle()
                    }
                }
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(height: height)
        .clipped()
        .alert("Are you sure to delete view?", isPresented: $canvasModel.showDeleteAlert) {
            Button(role: .destructive) {
                if let item = canvasModel.currentlyTappedItem {
                    let index = getIndex(stackItem: item)
                    canvasModel.stack.remove(at: index)
                }
            } label: {
                Text("Yes")
            }

        }
    }
    
    func getIndex(stackItem: StackItem)->Int {
        return canvasModel.stack.firstIndex { item in
            return item.id == stackItem.id
        } ?? 0
    }
    
    func moveViewToFront(stackItem: StackItem) {
        let currentIndex = getIndex(stackItem: stackItem)
        let lastIndex = canvasModel.stack.count - 1
//        canvasModel.stack.swapAt(currentIndex, lastIndex)
        canvasModel.stack
            .insert(canvasModel.stack.remove(at: currentIndex), at: lastIndex)
    }
}

#Preview {
    Home()
}

struct CanvasSubView<Content: View>: View {
    var content: Content
    @Binding var stackItem: StackItem
    var moveFront: ()->()
    var onDelete: ()->()
    
    init(stackItem: Binding<StackItem>, @ViewBuilder content: @escaping ()-> Content, moveFront: @escaping ()->(), onDelete: @escaping ()->()) {
        self.content = content()
        self._stackItem = stackItem
        self.moveFront = moveFront
        self.onDelete = onDelete
    }
    
    @State var hapticScale: CGFloat = 1
    var body: some View {
        content
            .rotationEffect(stackItem.rotation)
            .scaleEffect(stackItem.scale < 0.4 ? 0.4 : stackItem.scale)
            .scaleEffect(hapticScale)
            .offset(stackItem.offset)
            .gesture(
            TapGesture(count: 2)
                .onEnded({ value in
                    onDelete()
                })
                .simultaneously(with: LongPressGesture(minimumDuration: 0.3).onEnded({ value in
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation(.easeInOut) {
                        hapticScale = 1.2
                    }
                    
                    withAnimation(.easeInOut.delay(0.1)) {
                        hapticScale = 1
                    }
                    
                    moveFront()
                }))
            )
            .gesture(
             DragGesture()
                .onChanged({ value in
                    stackItem.offset = CGSize(width: stackItem.lastOffset.width + value.translation.width, height: stackItem.lastOffset.height + value.translation.height)
                }).onEnded({ value in
                    stackItem.lastOffset = stackItem.offset
                })
            )
            .gesture(
                MagnifyGesture()
                    .onChanged({ value in
                        stackItem.scale = stackItem.lastScale + (value.magnification - 1)
                    }).onEnded({ value in
                        stackItem.lastScale = stackItem.scale
                    })
                    .simultaneously(with: 
                                  RotateGesture()
                        .onChanged({ value in
                            stackItem.rotation = stackItem.lastRotation + value.rotation
                        })
                            .onEnded({ value in
                                stackItem.lastRotation = stackItem.rotation
                            })
                                    )
                
            )
    }
}
