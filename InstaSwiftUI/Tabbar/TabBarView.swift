//
//  MainView.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 19/04/23.
//

import SwiftUI

struct TabBarView: View {
    @State private var isNavigationBarHidden = false
    @State private var searchText = ""
    var body: some View {
        TabView {
            HomeView(viewModel: HomeVM())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .onAppear {
                    isNavigationBarHidden = false
                }
                .tag(0)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.text.rectangle")
                }
                .onAppear {
                    isNavigationBarHidden = true
                }
                .tag(1)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .onAppear {
                    isNavigationBarHidden = true
                }
                .tag(2)
        }
        if isNavigationBarHidden {
            VStack {}
            .navigationBarHidden(true)
        } else {
            VStack {}
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(APIClient.shared.searchString)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("Search...")
            )
            .onSubmit(of: .search) {
                // viewModel.searchAction(text: searchText)
            }
        }
    }
}

struct SearchPreferenceKey: PreferenceKey {
    static var defaultValue: String = APIClient.shared.searchString
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
