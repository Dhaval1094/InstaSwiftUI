//
//  MainView.swift
//  InstaSwiftUI
//
//  Created by Gwl on 19/04/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeVM())
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}
