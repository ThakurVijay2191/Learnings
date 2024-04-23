//
//  Sample.swift
//  Instagram
//
//  Created by Nap Works on 25/03/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                CompositionalView(items: composData, id: \.id, spacing: 2, alignment: .top) { item in
                    GeometryReader{reader in
                        if item.canPlay {
                            CustomReelPlayer(reel: item.reel)
                        }else {
                            Image("sajal")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: reader.size.width, height: reader.size.height)
                                .clipped()
                        }
                        
                    }
                }

            }
            .padding(.top, edges?.top)
        }

    }
}

struct CompositionalView<Content, Item, ID>: View where Content: View, ID: Hashable, Item: RandomAccessCollection, Item.Element: Hashable{
    var content: (Item.Element)->Content
    var items: Item
    var id: KeyPath<Item.Element, ID>
    var spacing: CGFloat
    var alignment: VerticalAlignment
    init(items: Item, id: KeyPath<Item.Element, ID>, spacing: CGFloat = 5, alignment: VerticalAlignment = .top, @ViewBuilder content: @escaping (Item.Element)->Content) {
        self.content = content
        self.id = id
        self.items = items
        self.spacing = spacing
        self.alignment = alignment
    }
    var body: some View {
        LazyVStack (spacing: spacing){
            ForEach(generateColumns(), id: \.self){ row in
                RowView(row: row)
            }
        }
    }
    
    func layoutType(row: [Item.Element])->LayoutType{
        let index = generateColumns().firstIndex { item in
            return item == row
        } ?? 0
        
        var types: [LayoutType] = []
        generateColumns().forEach { _ in
            if types.isEmpty {
                types.append(.type1)
            }else if types.last == .type1 {
                types.append(.type3)
            }else if types.last == .type3 {
                types.append(.type1)
            }else {
                
            }
        }
        
        return types[index]
    }
    
    @ViewBuilder
    func RowView(row: [Item.Element])->some View {
        GeometryReader{ proxy in
            let width = proxy.size.width
            let height = (proxy.size.height - spacing) / 2
            let type = layoutType(row: row)
            
            let columnWidth = (width > 0 ? ((width - (spacing * 2)) / 3) : 0)
            
            HStack (alignment: alignment,spacing: spacing){
                if type == .type1 {
                    
                    VStack (spacing: spacing){
                        HStack (spacing: spacing){
                            SafeView(row: row, index: 0)
                                .frame(height: height)
                            SafeView(row: row, index: 1)
                                .frame(height: height)
                        }
                        HStack (spacing: spacing){
                            SafeView(row: row, index: 2)
                                .frame(height: height)
                            SafeView(row: row, index: 3)
                                .frame(height: height)
                        }
                    }
                    
                    SafeView(row: row, index: 4)
                        .frame(width: columnWidth)
                    
                   
                    
                }
                
                if type == .type3 {
                    SafeView(row: row, index: 0)
                        .frame(width: columnWidth)
                    VStack (spacing: spacing){
                        HStack (spacing: spacing){
                            SafeView(row: row, index: 1)
                                .frame(height: height)
                            SafeView(row: row, index: 2)
                                .frame(height: height)
                        }
                        HStack (spacing: spacing){
                            SafeView(row: row, index: 3)
                                .frame(height: height)
                            SafeView(row: row, index: 4)
                                .frame(height: height)
                        }
                    }
                }
            }
        }
        .frame(height: layoutType(row: row) == .type1 || layoutType(row: row) == .type3 ? rowHeightLarge : rowHeightSmall)
    }
    
    var rowHeightLarge: CGFloat {
        return (rect.width / 3) * 2
    }
    
    var rowHeightSmall: CGFloat {
        return (rect.width / 3)
    }
    
    @ViewBuilder
    func SafeView(row: [Item.Element], index: Int)->some View{
        if (row.count - 1) >= index {
            content(row[index])
        }
    }
    
    func generateColumns()->[[Item.Element]] {
        var columns: [[Item.Element]] = []
        var row: [Item.Element] = []
        
        for item in items {
            if row.count == 5 {
                columns.append(row)
                row.removeAll()
                row.append(item)
            }else {
                row.append(item)
            }
        }
        
        columns.append(row)
        row.removeAll()
        
        return columns
    }
    
    
}

#Preview {
    SearchView()
}

enum LayoutType {
    case type1
    case type2
    case type3
}
