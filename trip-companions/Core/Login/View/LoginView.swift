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
            Text("우리들의 여행")
                .font(.headline)
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "message.fill")
                    Spacer()
                    Text("카카오 로그인")
                    Spacer()
                }
                .font(.title3)
                .foregroundColor(.black)
                .padding()
                .padding(.horizontal)
                .background(Color.yellow)
                .frame(width: 300)
            }
        }
    }
}

#Preview {
    LoginView()
}
