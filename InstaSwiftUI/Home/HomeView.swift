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
//                                AsyncImage(
//                                    url: URL(string: item.src?.small ?? "")!,
//                                    placeholder: {
//                                        Image("placeholder")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: imgRatio, height: imgRatio)
//                                    },
//                                    image: {
//                                        Image(uiImage: $0)
//                                            .resizable()
//                                    }
//                                )
//                                .frame(width: imgRatio, height: imgRatio)
//                                .aspectRatio(contentMode: .fill)
//                                AsyncImage(url: URL(string: item.src?.small ?? "")!) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFill()
//                                } placeholder: {
//                                    Image("placeholder")
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: imgRatio, height: imgRatio)
//                                }
//                                .frame(width: imgRatio, height: imgRatio)
                                AsyncImage(url: URL(string: item.src?.small ?? "")!) { phase in
                                    switch phase {
                                        case .empty, .failure:
                                            PlaceHolderImageView(imgRatio: imgRatio)
                                        case .success(let image):
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: imgRatio, height: imgRatio)
                                        @unknown default:
                                            EmptyView()
                                    }
                                }
                                if viewModel.isLast(item: item) {
                                    LoadMoreView()
                                        .onAppear {
                                            viewModel.loadMore()
                                        }
                                }
                            }
                            .padding(2.5)
                        }
                        .navigationTitle(APIClient.shared.searchString)
                    }
                    .refreshable {
                        viewModel.loadMore()
                    }
                }
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search...")
                )
                .onSubmit(of: .search) {
                    viewModel.searchAction(text: searchText)
                }
                .onAppear {
                    viewModel.getSearchList()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeVM())
    }
}

struct PlaceHolderImageView: View {
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

struct LoadMoreView: View {
    var body: some View {
        VStack {}
    }
}
