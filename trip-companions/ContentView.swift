//
//  ContentView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            if authManager.currentMember != nil && authManager.isLoggedIn {
                MainTabView()
                    .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
            } else if authManager.currentMember == nil && authManager.isLoggedIn == true {
                InfoCollectionView()
                    .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
            } else {
                LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
                    .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
            }
            
//            MainTabView()
//                .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
//            LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
//                .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
}
