//
//  ContentView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State var showingMainView = false
    
    var body: some View {
        VStack {
//            if showingMainView {
//                if authManager.currentMember?.nickName != nil && authManager.isLoggedIn {
//                    MainTabView()
//                        .environmentObject(getMyPageViewModel())
//                        .environmentObject(getGenderAndMbtiViewModel())
//                } else if authManager.currentMember?.nickName == nil && authManager.isLoggedIn == true {
//                    InfoCollectionView(isEditMode: false)
//                        .environmentObject(getMyPageViewModel())
//                        .environmentObject(getGenderAndMbtiViewModel())
//                } else {
//                    LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
//                        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
//                }
//            } else {
//                SplashView()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                            withAnimation {
//                                showingMainView = true
//                            }
//                        }
//                    }
//            }
            MainTabView()
                .environmentObject(getMyPageViewModel())
                .environmentObject(getGenderAndMbtiViewModel())
        }
        
    }
    
    func getMyPageViewModel() -> MyPageViewModel {
        if let currentMember = authManager.currentMember {
            return MyPageViewModel(member: currentMember)
        } else {
            return MyPageViewModel.MOCK_VIEW_MODEL
        }
    }
    
    func getGenderAndMbtiViewModel() -> MetaDataViewModel {
        return MetaDataViewModel()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
}
