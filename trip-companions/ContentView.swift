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
            if authManager.currentMember?.nickName != nil && authManager.isLoggedIn {
                MainTabView()
                    .environmentObject(getMyPageViewModel())
                    .environmentObject(getGenderAndMbtiViewModel())
            } else if authManager.currentMember?.nickName == nil && authManager.isLoggedIn == true {
                InfoCollectionView(isEditMode: false)
                    .environmentObject(getMyPageViewModel())
                    .environmentObject(getGenderAndMbtiViewModel())
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
    
    func getMyPageViewModel() -> MyPageViewModel {
        if let currentMember = authManager.currentMember {
            return MyPageViewModel(member: currentMember)
        } else {
            return MyPageViewModel.MOCK_VIEW_MODEL
        }
    }
    
    func getGenderAndMbtiViewModel() -> GenderAndMbtiViewModel {
        return GenderAndMbtiViewModel()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
}
