//
//  ShareLink.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 02/09/23.
//

import SwiftUI

struct ShareLink: View {
    var sampleImage = ImageFile(image: Image(systemName: "Person"))
    private let shareItem = URL(string: "https://medium.com/@sghanshyampadnekar")!

    var body: some View {
        VStack {
//            ShareLink(item: sampleImage)
        }
    }
}

struct ShareLink_Previews: PreviewProvider {
    static var previews: some View {
        ShareLink()
    }
}

struct ImageFile: Transferable {
    var image: Image
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}
