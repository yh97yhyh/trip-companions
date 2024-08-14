//
//  LoginView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("kakaoLoginLogo")
                .resizable()
//                .scaledToFit()
                .frame(width: 180, height: 180)
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "message.fill")
                    Spacer()
                    Text("카카오 로그인")
                        .font(.callout)
                    Spacer()
                }
            }
            .buttonStyle(KakaoButtonStyle())
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
