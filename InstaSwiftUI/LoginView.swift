//
//  LoginView.swift
//  InstaUI
//
//  Created by iOS Developer on 13/04/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State private var scaling = false
    @State private var isShowingDetailView = false

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
                NavigationLink(
                    destination: Text("Second View"), isActive: $isShowingDetailView) {
                        EmptyView()
                    }
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 15)
                TextField("Username or Email",text:$email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                    .padding(.top, 0)
                HStack(spacing: 15){
                    VStack{
                        if visible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                    }
                    Button(action: {
                        visible.toggle()
                    }) {
                        Image(systemName: visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(color)
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(borderColor,lineWidth: 2))
                .padding(.top, 10)
                HStack{
                    Spacer()
                    Button(action: {
                        showPassword()
                        visible.toggle()
                    }) {
                        Text("Forget Password")
                            .fontWeight(.medium)
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 10.0)
                }
                .padding(.bottom, 40)
                // Sign in button
                Button(action: {
                    verify()
                    isShowingDetailView = true
                }) {
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
                .alert(isPresented: $alert){()->Alert in
                    return Alert(title: Text("\(title)"), message: Text("\(error)"), dismissButton:
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
    
    func verify(){
        guard !email.isEmpty && !password.isEmpty else {
            title = "Login Error"
            error = "Please fill all the content property"
            alert = true
            return
        }
    }
    
    func showPassword(){
        title = "Credentials"
        error = "User name is '\(Constants.credentials.userName)' and password is '\(Constants.credentials.password)'"
        alert = true
    }
}
