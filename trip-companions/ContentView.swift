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
            if showingMainView {
                if (authManager.currentMember?.interestRegion != nil && authManager.isLoggedIn) || authManager.isGuestMode {
                    MainTabView(viewModel: MainTabViewModel.shared)
                        .environmentObject(getMyPageViewModel())
                        .environmentObject(getMetaDataViewModel())
                } else if authManager.currentMember?.interestRegion == nil && authManager.isLoggedIn {
                    NavigationStack {
                        InfoCollectionView(isEditMode: false)
                            .environmentObject(getMyPageViewModel())
                            .environmentObject(getMetaDataViewModel())
                    }
                }
                else {
                    LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
                        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
                }
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showingMainView = true
                            }
                        }
                    }
            }
        }
        
    }
    
    func getMyPageViewModel() -> MyPageViewModel {
        if let currentMember = authManager.currentMember {
            return MyPageViewModel(member: currentMember)
        } else {
            return MyPageViewModel.MOCK_VIEW_MODEL
        }
    }
    
    func getMetaDataViewModel() -> MetaDataViewModel {
        return MetaDataViewModel.shared
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
}
