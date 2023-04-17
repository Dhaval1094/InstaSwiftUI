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
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    var body: some View {
        ZStack {
            NavigationStack {
                GeometryReader { geo in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            let imgRatio = geo.size.width / 3.1
                            ForEach(viewModel.photos, id: \.id) { item in
                                AsyncImage(
                                    url: URL(string: item.src?.small ?? "")!,
                                    placeholder: {
                                        Image("placeholder")
                                            .resizable()
                                            .frame(width: imgRatio, height: imgRatio)
                                    },
                                    image: {
                                        Image(uiImage: $0)
                                            .resizable()
                                    }
                                )
                                .frame(width: imgRatio, height: imgRatio)
                                .aspectRatio(contentMode: .fill)
                            }
                            .padding(2.5)
                        }
                        .navigationTitle(APIClient.shared.searchString)
                    }
                    .refreshable {
                        viewModel.loadMore()
                    }
                }
                .navigationBarBackButtonHidden(true)
                .searchable(
                    text: $searchText,
                    placement: .toolbar,
                    prompt: Text("Search...")
                )
                .onSubmit(of: .search) {
                    APIClient.shared.searchString = searchText
                    viewModel.reset()
                    viewModel.getSearchList()
                }
            }
            .onAppear {
                viewModel.getSearchList()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeVM())
    }
}
