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

//struct ContentView: View {
//    @EnvironmentObject var authManager: AuthManager
//    @State var showingMainView = false
//    @State private var myPageViewModel: MyPageViewModel?
//    @State private var metaDataViewModel: MetaDataViewModel = MetaDataViewModel.shared
//    
//    var body: some View {
//        VStack {
//            if showingMainView {
//                if (authManager.currentMember?.interestRegion != nil && authManager.isLoggedIn) || authManager.isGuestMode {
//                    if let myPageViewModel = myPageViewModel {
//                        MainTabView(viewModel: MainTabViewModel.shared)
//                            .environmentObject(myPageViewModel)
//                            .environmentObject(metaDataViewModel)
//                    }
//                } else if authManager.currentMember?.interestRegion == nil && authManager.isLoggedIn {
//                    NavigationStack {
//                        if let myPageViewModel = myPageViewModel {
//                            InfoCollectionView(isEditMode: false)
//                                .environmentObject(myPageViewModel)
//                                .environmentObject(metaDataViewModel)
//                        }
//                    }
//                } else {
//                    LoginView(viewModel: LoginViewModel.MOCK_VIEW_MODEL)
//                        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
//                }
//            } else {
//                SplashView()
//                    .onAppear {
//                        myPageViewModel = getMyPageViewModel()
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                            withAnimation {
//                                showingMainView = true
//                            }
//                        }
//                    }
//            }
//        }
//    }
//    
//    func getMyPageViewModel() -> MyPageViewModel {
//        if let currentMember = authManager.currentMember {
//            return MyPageViewModel(member: currentMember)
//        } else {
//            return MyPageViewModel.MOCK_VIEW_MODEL
//        }
//    }
//}

#Preview {
    ContentView()
        .environmentObject(AuthManager.shared)
}
