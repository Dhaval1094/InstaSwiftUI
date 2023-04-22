//
//  ProfileView.swift
//  InstaUI
//
//  Created by iOS Developer on 13/04/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileVM
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack {
                    Spacer()
                    Text("dhaval_10_10")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Image("bluetick")
                        .resizable()
                        .frame(
                            width: 16,
                            height: 16
                        )
                    Spacer()
                }
                VStack{
                    HStack {
                        let imgRatio = geo.size.width / 3.8
                        Image("profile_image")
                            .resizable()
                            .frame(
                                width: imgRatio,
                                height: imgRatio,
                                alignment: .top
                            )
                            .clipShape(Circle())
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: (imgRatio + 5) / 2
                                ).stroke(
                                    viewModel.borderColor,
                                    lineWidth: 5
                                )
                                .padding(.all, -5)
                            )
                            .padding(.leading, 20)
                            .padding(.top, 20)
                        Spacer()
                        VStack {
                            Text("266")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Posts")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        .padding(10)
                        VStack {
                            Text("974k")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Followers")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        .padding(10)
                        VStack {
                            Text("785")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Following")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        .padding(10)
                        Spacer()
                    }
                    HStack {
                        Text("iOS Developer")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .background(Color.yellow)
                    .padding(.leading, 20)
                }
                .padding(.top, 20)
            }
        }
//        .background(Color.red)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileVM())
    }
}
