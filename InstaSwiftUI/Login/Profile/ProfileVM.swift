//
//  ProfileVM.swift
//  InstaSwiftUI
//
//  Created by Dhaval Trivedi on 15/04/23.
//

import SwiftUI

class ProfileVM: ObservableObject {
    let borderColor = LinearGradient(
        gradient: Gradient(
            colors: [ .red, .orange, .pink, .red, .purple ]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )

}
