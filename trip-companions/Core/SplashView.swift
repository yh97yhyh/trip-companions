//
//  SplashView.swift
//  trip-companions
//
//  Created by 영현 on 9/9/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("kakaoLoginLogo")
                    .resizable()
    //                .scaledToFit()
                    .frame(width: 180, height: 180)
            }
        }
    }
}

#Preview {
    SplashView()
}
