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
    @State var alert = false    
    @State var isSignIn = false
    @State var isForgotPassword = false
    @State var visible = false
    var body: some View{
        ZStack {
            NavigationStack {
                VStack {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 255.0, height: 255.0, alignment: .top)
                        .padding(.top, 40)
                        .scaleEffect(scaling ? 0.8 : 1)
                        .onAppear {
                            withAnimation(
                                .spring(response: 0.8, dampingFraction: 0.08, blendDuration: 0.0)
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
                        .frame(height: 20)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(viewModel.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    HStack(spacing: 15) {
                        VStack{
                            if visible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        Button {
                            visible.toggle()
                        } label: {
                            Image(systemName: visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(viewModel.color)
                                .opacity(0.8)
                        }
                    }
                    .frame(height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6)
                        .stroke(viewModel.borderColor,lineWidth: 2))
                    .padding(.top, 10)
                    HStack{
                        Spacer()
                        Button {
                            viewModel.forgotPassword()
                            isForgotPassword.toggle()
                        } label: {
                            Text("Forget Password")
                                .fontWeight(.medium)
                                .foregroundColor(.orange)
                            // Alert for forgot password
                                .alert(isPresented: $isForgotPassword) {()->Alert in
                                    return Alert(
                                        title: Text("\(viewModel.title)"),
                                        message: Text("\(viewModel.error)"),
                                        dismissButton: .default(Text("OK").fontWeight(.semibold)))
                                }
                        }
                        .padding(.top, 10.0)
                    }
                    .padding(.bottom, 40)
                    // Sign in button
                    Text("Sign in")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: 200)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [ .yellow, .orange, .pink, .red, .purple ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .opacity(0.8)
                        )
                        .cornerRadius(6)
                        .padding(.top, 15)
                    // Alert for invalid credentials
                        .alert(isPresented: $alert) {()->Alert in
                            return Alert(
                                title: Text("\(viewModel.title)"),
                                message: Text("\(viewModel.error)"),
                                dismissButton: .default(Text("OK").fontWeight(.semibold)))
                        }
                        .onTapGesture {
                            if viewModel.verify(email: email, password: password) {
                                isSignIn.toggle()
                            } else {
                                alert.toggle()
                            }
                        }
                        .navigationDestination(isPresented: $isSignIn) {
                            MainView()                            
                        }
                        .padding(.bottom, 50)
                    Spacer()
                }
                .onAppear {
                    email = Constants.credentials.userName
                    password = Constants.credentials.password
                }
                .padding(.horizontal, 25)
            }
        }
    }
}
