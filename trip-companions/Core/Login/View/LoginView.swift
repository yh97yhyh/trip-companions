//
//  LoginView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            LandingImageView()
            
            VStack {
                VStack {
                    Text("프로필을 등록하고\n") +
                    Text("딱 맞는 여행 메이트")
                        .fontWeight(.bold) +
                    Text("를 찾아볼까요?")
                }
                .multilineTextAlignment(.center)
                .padding(.top, 40)
                .padding(.bottom)
                
                Button {
                    viewModel.kakaoLogin()
                } label: {
                    HStack {
                        Image("icn_kakao")
                        Spacer()
                        Text("카카오 로그인")
                        Spacer()
                    }
                }
                .buttonStyle(KakaoButtonStyle())
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                Button {
                    viewModel.appleLogin()
                } label: {
                    HStack {
                        Image("icn_apple")
                        Spacer()
                        Text("Apple 로그인")
                        Spacer()
                    }
                }
                .buttonStyle(AppleButtonStyle())
                .padding(.horizontal)
                
                
                Spacer()
                
                Button {
                    viewModel.guest()
                } label: {
                    Text("회원가입 없이 둘러보기")
                        .foregroundColor(.grayA2A2A2)
                        .underline(true, color: .grayA2A2A2)
                }
                .padding(.bottom, 40)
            }
            .frame(height: UIScreen.main.bounds.height / 2)
            .background(Color.white) // 배경 색상 설정
            .clipShape(
                .rect(
                    topLeadingRadius: 40,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 40
                )
            )
            .shadow(radius: 10)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct LandingImageView: View {
    var body: some View {
        VStack {
            HStack {
                Text("당신의 취향에 맞는\n")
                    .font(.title) +
                Text("동행과 함께 ")
                    .font(.title)
                    .fontWeight(.bold) +
                Text("특별한 인연을\n만들어 보세요")
                    .font(.title)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .background(Image("landing").resizable().scaledToFill())
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
