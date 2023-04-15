//
//  LoginVM.swift
//  InstaUI
//
//  Created by Gwl on 15/04/23.
//

import SwiftUI

class LoginVM: ObservableObject {
    @State var color = Color.black.opacity(0.7)    
    var error = ""
    var title = ""
    let borderColor = LinearGradient(
        gradient: Gradient(
            colors: [ .red, .pink, .orange, .red, .purple ]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )
    func verify(email: String, password: String) -> Bool {
        guard !email.isEmpty && !password.isEmpty else {
            title = "Login Error"
            error = "Please fill all the content property"
            return false
        }
        guard email == Constants.credentials.userName else {
            title = "Login Error"
            error = "Invalid email ID"
            return false
        }
        guard password == Constants.credentials.password else {
            title = "Login Error"
            error = "Invalid password"
            return false
        }
        return true
    }    
    func forgotPassword() {
        title = "Credentials"
        error = "User name is '\(Constants.credentials.userName)' and password is '\(Constants.credentials.password)'"
    }
}
