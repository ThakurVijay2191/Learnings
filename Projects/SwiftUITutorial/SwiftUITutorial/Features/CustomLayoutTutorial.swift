//
//  CustomLayoutTutorial.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 09/09/23.
//

import SwiftUI

struct CustomLayoutTutorial: View {
    var body: some View {
      //Use as normal stack view
        
        CustomStack{
            ForEach(1...5, id: \.self){ index in
                Circle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                    .overlay {
                        Text("\(index)")
                    }
            }
        }
        .frame(height: 300)
    }
}

struct CustomLayoutTutorial_Previews: PreviewProvider {
    static var previews: some View {
        CustomLayoutTutorial()
    }
}

//MARK: - New Custom Layout
//It will help us to create our own custom layout and gives more flexiblity to use

struct CustomStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        //Here calculate and return the container size
        //For eg. we are passing the exact proposal size
        // to make it center calculate the required width instead of max width
        let requiredWidth = subviews.compactMap { view -> Double? in
            return view.sizeThatFits(.unspecified).width
        }.max()
        return .init(width: requiredWidth ?? 100, height: proposal.height ?? 100)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        //Place Views Here
        var origin = bounds.origin
        for subview in subviews {
            subview.place(at: origin, anchor: .topLeading, proposal: proposal)
            //for placing view at vertical
            //Adding each view size to origin
            //so the next view will place below the current view
            origin.y += subview.sizeThatFits(.unspecified).height
//            origin.x += subview.sizeThatFits(.unspecified).width
            //for horizontal just change it to x and width
        }
        
        //we can customize it more for our usage
    }
    
    
}
