//
//  AutoLayoutAPI.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct LayoutAPI: View {
    @State var tags: [Tag] = rawTags.compactMap{ tag-> Tag? in
        return .init(name: tag)
    }
    //MARK: - Segment Value
    @State var alignmentValue: Int = 0
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $alignmentValue) {
                    Text("Leading")
                        .tag(0)
                    Text("Center")
                        .tag(1)
                    Text("Trailing")
                        .tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 20)
                TagView(alignment: alignmentValue == 0 ? .leading : alignmentValue == 1 ? .center : .trailing, spacing: 10){
                    ForEach($tags) { $tag in
                        Toggle(tag.name, isOn: $tag.isSelected)
                            .toggleStyle(.button)
                            .buttonStyle(.bordered)
                            .tint(tag.isSelected ? .red : .gray)
                    }
                }
                .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6), value: alignmentValue)
                
                HStack {
                    TextField("Tag", text: $text, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    // if it acceeds, then it will enable scrollview
                        .lineLimit(1...5)
                    
                    Button("Add") {
                        withAnimation(.spring()) {
                            tags.append(Tag(name: text))
                            text = ""
                        }
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 4))
                    .tint(.red)
                    .disabled(text == "")
                }

            }
       
            .padding(15)
            .navigationTitle(Text("Layout"))
        }
    }
}

struct LayoutAPI_Previews: PreviewProvider {
    static var previews: some View {
        LayoutAPI()
    }
}

struct TagView: Layout{
    var alignment: Alignment = .center
    var spacing: CGFloat = 10
    init(alignment: Alignment, spacing: CGFloat) {
        self.alignment = alignment
        self.spacing = spacing
    }
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return .init(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        ///Placing views
        ///I am going to build it in two ways
        ///One is simple without customisation
        ///Another one with customization
        
        ///Note Use origin
        ///Since Origin will start from applied padding from parent view
        var origin = bounds.origin
        let maxWidth = bounds.width
        var row: ([LayoutSubviews.Element], Double) = ([], 0.0)
        var rows: [([LayoutSubviews.Element], Double)] = []
        
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)
            if (origin.x + viewSize.width + spacing) > maxWidth {
                row.1 = (bounds.maxX - origin.x + bounds.minX + spacing)
                rows.append(row)
                row.0.removeAll()
                origin.x = bounds.origin.x
                row.0.append(view)
                origin.x += (viewSize.width + spacing)
            }else{
                row.0.append(view)
                origin.x += (viewSize.width + spacing)
            }
        }
        
        //MARK: - Exhaust ones
        if !row.0.isEmpty {
            row.1 = (bounds.maxX - origin.x + bounds.minX + spacing)
            rows.append(row)
        }
        
        origin = bounds.origin
        for row in rows {
            origin.x = (alignment == .leading ? bounds.minX : (alignment == .trailing ? row.1 : row.1 / 2))
            for view in row.0 {
                let viewSize = view.sizeThatFits(proposal)
                view.place(at: origin, proposal: proposal)
                origin.x += (viewSize.width + spacing)
            }
            
            let maxHeight = row.0.compactMap { view-> CGFloat? in
                return view.sizeThatFits(proposal).height
            }.max() ?? 0
            
            origin.y+=(maxHeight+spacing)
        }
//        subviews.forEach { view in
//            let viewSize = view.sizeThatFits(proposal)
//            if (origin.x + viewSize.width + spacing) > maxWidth {
//                origin.y += (viewSize.height + spacing)
//                origin.x = bounds.origin.x
//                view.place(at: origin, proposal: proposal)
//                //updating origin for next view placement
//                origin.x += (viewSize.width + spacing)
//            }else{
//                view.place(at: origin, proposal: proposal)
//                //updating origin for next view placement
//                origin.x += (viewSize.width + spacing)
//            }
//        }
        
    }
    
    
}

var rawTags: [String] = [
"SwiftUI", "XCode", "Apple", "WWDC 22", "iOS 16", "iPadOS 16", "macOS 13", "watchOS 9", "XCode 14", "API's"
]

//MARK: TAG Model
struct Tag: Identifiable {
    var id = UUID().uuidString
    var name: String
    var isSelected: Bool = false
}

