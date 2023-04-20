//
//  HomeView.swift
//  InstaUI
//
//  Created by iOS Developer on 13/04/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeVM
    @State private var searchText = ""
    @State private var offset = CGFloat.zero
    var body: some View {
        ZStack {
            NavigationStack {
                GeometryReader { geo in
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns(count: 3), spacing: 0) {
                            let imgRatio = geo.size.width / 3.1
                            ForEach(viewModel.photos, id: \.id) { item in
                                AsyncImage(url: URL(string: item.src?.small ?? "")!) { phase in
                                    switch phase {
                                        case .empty, .failure:
                                            PlaceHolderView(imgRatio: imgRatio)
                                        case .success(let image):
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: imgRatio, height: imgRatio)
                                                .contentShape(Rectangle())
                                                .clipped()
                                        @unknown default:
                                            EmptyView()
                                    }
                                }
                                .padding(.top, 1.0)
                                if viewModel.isLast(item: item) {
                                    LoadMoreView()
                                        .onAppear {
                                            viewModel.loadMore()
                                        }
                                }
                            }
                            .padding(2.5)
                        }
                    }
                    .refreshable {
                        viewModel.loadMore()
                    }
                }
                .onAppear {
                    viewModel.getSearchList()
                }
            }
            .padding(.top, 0.1)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeVM())
    }
}

struct LoadMoreView: View {
    var body: some View {
        VStack {}
    }
}
