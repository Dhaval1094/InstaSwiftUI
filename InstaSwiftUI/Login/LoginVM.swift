//
//  LoginVM.swift
//  InstaUI
//
//  Created by Gwl on 15/04/23.
//

import SwiftUI

class LoginVM: ObservableObject {
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State var isShowingDetailView = false

    let borderColor = LinearGradient(
        gradient: Gradient(
            colors: [
                .red,
                .pink,
                .orange,
                .red,
                .purple
            ]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )    
}
