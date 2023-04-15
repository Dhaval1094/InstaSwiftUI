//
//  LoginView.swift
//  InstaUI
//
//  Created by iOS Developer on 13/04/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginVM
    @State private var scaling = false
    @State var email = ""
    @State var password = ""
    var body: some View{
        ZStack {
            VStack {
                Image("appLogo")
                    .resizable()
                    .frame(width: 255.0, height: 255.0, alignment: .top)
                    .padding(.top, 40)
                    .scaleEffect(scaling ? 0.8 : 1)
                    .onAppear {
                        withAnimation(
                            .spring(response: 1.0, dampingFraction: 0.08, blendDuration: 0.0)
                            .repeatCount(1, autoreverses: true)
                        ) {
                            scaling.toggle()
                        }
                    }
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                TextField("Username or Email",text:$email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:6).stroke(viewModel.borderColor,lineWidth:2))
                    .padding(.top, 0)
                HStack(spacing: 15) {
                    VStack{
                        if viewModel.visible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                    }
                    Button {
                        viewModel.visible.toggle()
                    } label: {
                        Image(systemName: viewModel.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(viewModel.color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(viewModel.borderColor,lineWidth: 2))
                .padding(.top, 10)
                HStack{
                    Spacer()
                    Button {
                        showPassword()
                        viewModel.visible.toggle()
                    } label: {
                        Text("Forget Password")
                            .fontWeight(.medium)
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 10.0)
                }
                .padding(.bottom, 40)
                // Sign in button
                    Button {
                        verify()
                        viewModel.isShowingDetailView = true
                    } label: {
                        Text("Sign in")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: 200)
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .yellow,
                                    .orange,
                                    .pink,
                                    .red,
                                    .purple
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .opacity(0.8)
                    )
                    .cornerRadius(6)
                    .padding(.top, 15)
                    .alert(isPresented: $viewModel.alert) {()->Alert in
                        return Alert(title: Text("\(viewModel.title)"), message: Text("\(viewModel.error)"), dismissButton:
                                .default(Text("OK").fontWeight(.semibold)))
                    }
                Spacer()
            }
            .onAppear {
                email = Constants.credentials.userName
                password = Constants.credentials.password
            }
            .padding(.horizontal, 25)
        }
    }
    
    func verify() {
        guard !email.isEmpty && !password.isEmpty else {
            viewModel.title = "Login Error"
            viewModel.error = "Please fill all the content property"
            viewModel.alert = true
            return
        }
    }
    
    func showPassword() {
        viewModel.title = "Credentials"
        viewModel.error = "User name is '\(Constants.credentials.userName)' and password is '\(Constants.credentials.password)'"
        viewModel.alert = true
    }
}
