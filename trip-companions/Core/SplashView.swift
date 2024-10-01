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
                Image("splash")
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}

#Preview {
    SplashView()
}
