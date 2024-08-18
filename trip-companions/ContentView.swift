//
//  ContentView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainTabView()
                .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
//            LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
//                .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
        }
    }
}

#Preview {
    ContentView()
}
