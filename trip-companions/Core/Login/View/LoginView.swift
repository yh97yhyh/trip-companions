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
            Spacer()
            
            Image("kakaoLoginLogo")
                .resizable()
//                .scaledToFit()
                .frame(width: 180, height: 180)
            
            Spacer()
            
            Button {
                viewModel.login()
            } label: {
                Image("kakao_login_large_wide")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: UIScreen.main.bounds.width * 0.9)
            }
            .padding(.horizontal)
            
//            Button {
//                
//            } label: {
//                HStack {
//                    Image(systemName: "message.fill")
//                    Spacer()
//                    Text("카카오 로그인")
//                        .font(.callout)
//                    Spacer()
//                }
//            }
//            .buttonStyle(KakaoButtonStyle())
//            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
