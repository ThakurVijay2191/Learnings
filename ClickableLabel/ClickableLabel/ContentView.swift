//
//  ContentView.swift
//  ClickableLabel
//
//  Created by Nap Works on 04/03/24.
//

import SwiftUI
import FRHyperLabel

struct ContentView: View {
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            let height = reader.size.height
            VStack{
                ScrollView {
                    VStack{
                        HyperLabel(width: width){ link in
                            if let link {
                                print("Link is: \(link)")
                            }
                        }
                        .background(.red)
//                        Text("Hello")
                    }
                }
               
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct HyperLabel: UIViewRepresentable {
    var width: CGFloat
    var onClick: (String?)->()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let label = FRHyperLabel()
        label.numberOfLines = 0;
        
        //Step 1: Define a normal attributed string for non-link texts
        let string = "By Checking the box you agree to the Terms & Conditions and our Privacy Policy"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                          NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
        
        label.attributedText = NSAttributedString(string: string, attributes: attributes)
        
        //Step 2: Define a selection handler block
        let handler = { (hyperLabel: FRHyperLabel?, substring: String?) -> Void in
//           print("Tapped on \(substring)")
            onClick(substring)
        }

        label.setLinksForSubstrings(["Terms & Conditions", "Privacy Policy"], withLinkHandler: handler)
       
        label.preferredMaxLayoutWidth = width
        let size = label.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        view.addSubview(label)
        return view
    }
   
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UILabel{
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
