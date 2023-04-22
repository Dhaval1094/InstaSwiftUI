//
//  InstaSwiftUIApp.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 15/04/23.
//

import SwiftUI

@main
struct InstaSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView(viewModel: ProfileVM())
        }
    }
}
