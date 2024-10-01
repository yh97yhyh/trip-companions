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
            Color.orangeF49321
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Image("splash_top")
                        .padding(.trailing)
                }
                .padding(.top, 95)
                Spacer()
                HStack {
                    Image("splash_bottom")
//                        .resizable()
//                        .scaledToFill()
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashView()
}
