//
//  TagView.swift
//  ChipLayout
//
//  Created by Nap Works on 09/03/24.
//

import SwiftUI

struct TagView<Content: View>: View {
    var content: (Binding<Tag>)-> Content
    @Binding var tags: [Tag]
    var title: String = "Add Some Tags"
    var fontSize: CGFloat = 16
    var totalWidth: CGFloat
    
    @Binding var index: Int
    init(totalWidth: CGFloat, index: Binding<Int>, items: Binding<[Tag]>, @ViewBuilder content: @escaping (Binding<Tag>)->Content) {
        self._tags = items
        self._index = index
        self.content = content
        self.totalWidth = totalWidth
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            VStack(alignment: .leading, spacing: 10, content: {
                ForEach(getRows(screenWidth: totalWidth), id: \.self) { $rows in
                    HStack (spacing: 10){
                        ForEach($rows) { $row in
                            content($row)
                        }
                    }
                }
            })
            .frame(width: totalWidth, alignment: .leading)
        })
        .onAppear {
            for i in 0..<tags.count {
                let tag = tags[i]
                let font = UIFont.systemFont(ofSize: fontSize)
                
                let attributes = [NSAttributedString.Key.font: font]
                
                let size = (tag.text as NSString).size(withAttributes: attributes)
                
                tags[i].size = size.width
            }
        }
      
    }

    
    func getIndex(tag: Tag)->Int{
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    func getRows(screenWidth: CGFloat)->Binding<[[Tag]]> {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var totalWidth: CGFloat = 0
        
        tags.forEach { tag in
            totalWidth += (tag.size + 20)
            
            if totalWidth > screenWidth {
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 20) : 0)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            }else {
                currentRow.append(tag)
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return Binding.constant(rows)
    }
}

#Preview {
    ContentView()
}

struct RowView: View {
    @Binding var tag: Tag
    var fontSize: CGFloat
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                tag.isSelected.toggle()
            }
        }, label: {
            Text(tag.text)
                .font(.system(size: fontSize))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(tag.isSelected ? .red : .tag)
                )
                .foregroundStyle(.BG)
                .lineLimit(1)
                .contentShape(.capsule)

        })
       
    }
  
}
