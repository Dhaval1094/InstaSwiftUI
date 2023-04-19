//
//  PlaceHolderView.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 19/04/23.
//

import SwiftUI

struct PlaceHolderView: View {
    @State var imgRatio: CGFloat = 0
    var body: some View {
        VStack {
            Image("placeholder")
                .resizable()
                .scaledToFill()
                .frame(width: imgRatio, height: imgRatio)
        }
    }
}
