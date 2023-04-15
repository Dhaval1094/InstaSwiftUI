//
//  GridLayoutCell.swift
//  InstaSwiftUI
//
//  Created by Gwl on 15/04/23.
//

import SwiftUI

struct GridLayoutCell: View {
    @State var item: Photo
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: URL(string: item.src?.small ?? ""))
        }
    }
}
