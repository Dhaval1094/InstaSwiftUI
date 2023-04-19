//
//  MainView.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 19/04/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeVM())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.text.rectangle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}
