//
//  InstaSwiftUIApp.swift
//  InstaSwiftUI
//
//  Created by Gwl on 15/04/23.
//

import SwiftUI

@main
struct InstaSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginVM())
        }
    }
}
