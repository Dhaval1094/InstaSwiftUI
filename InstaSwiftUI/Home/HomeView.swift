//
//  HomeView.swift
//  InstaUI
//
//  Created by iOS Developer on 13/04/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeVM
    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.photos, id: \.self) { item in
                    GridLayoutCell(
                        item: item
                    )
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
                    .buttonStyle(PlainButtonStyle())
                    .id(item.id)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarBackButtonHidden(true)
        }.onAppear {
            viewModel.getSearchList()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeVM())
    }
}
