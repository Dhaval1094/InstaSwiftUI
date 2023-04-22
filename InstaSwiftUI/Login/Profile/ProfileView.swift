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
                        let imgRatio = geo.size.width / 4.0
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
                        ProfileStatusView()
                        Spacer()
                    }
                    .padding(.bottom, 10.0)
                    HStack {
                        Text("🖥 iOS developer 📱🙌" + "\n" + "Life is full of HAPPINESS 😊 and TEARS 😢 ..Be STRONG 🤜🏻 and have FAITH" + "\n" + "😇🕉🇮🇳")
                            .lineLimit(4)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.trailing, 16.0)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    FollowersView(imgRatio: 50)
                        .padding(.leading, 10)
                    Button {
 
                    } label: {
                        Text("Follow")
                            .foregroundColor(Color.white)
                            .background(Color(UIColor.lightGray))
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    
                }
                .padding(.top, 20)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileVM())
    }
}

struct ProfileStatusView: View {
    var body: some View {
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
    }
}

struct FollowersView: View {
    @State var imgRatio = CGFloat.zero
    let followers = ["follower1", "follower2", "follower3"]
    var followedByMessage: AttributedString {
        var components = PersonNameComponents()
        components.givenName = "Followed by "
        components.familyName = "ellamayoreally, smads, and 1 other"
        var result = components.formatted(.name(style: .long).attributed)
        let familyNameStyling = AttributeContainer.font(.headline)
        let familyName = AttributeContainer.personNameComponent(.familyName)
        result.replaceAttributes(familyName, with: familyNameStyling)
        return result
    }
    var body: some View {
        HStack {
            HStack {
                ForEach(0...2, id: \.self) { count in
                    Image(followers[count])
                        .resizable()
                        .frame(
                            width: imgRatio,
                            height: imgRatio
                        )
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: imgRatio/2
                            ).stroke(
                                Color.white,
                                lineWidth: 3
                            )
                        )
                        .padding(.leading, -26)
                        .zIndex(CGFloat(-count))
                }
                .padding(.leading, 10)
            }
            Text(followedByMessage)
        }
    }
}
