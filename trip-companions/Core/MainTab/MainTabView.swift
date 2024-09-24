//
//  MainTabView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct MainTabView: View {
//    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel: MainTabViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                TabView(selection: $viewModel.selectedIndex) {
                    HomeView(viewModel: HomeViewModel.shared, showingNoSignInAlert: false)
                        .tabItem {
                            Image(viewModel.selectedIndex == 0 ? "icn_home_fill" : "icn_home")
                            Text("홈")
                        }
                        .tag(0)
                    DomesticCompanionView(viewModel: DomesticCompanionViewModel.shared, searchViewModel: SearchViewModel.shared)
                        .tabItem {
                            Image(viewModel.selectedIndex == 1 ? "icn_domestic_fill" : "icn_domestic")
                            Text("국내 동행")
                        }
                        .tag(1)
                    OverseaCompanionView()
                        .tabItem {
                            Image(viewModel.selectedIndex == 2 ? "icn_oversea_fill" : "icn_oversea")
                            Text("해외 동행")
                        }
                        .tag(2)
                    MyPageView()
                        .tabItem {
                            Image(viewModel.selectedIndex == 3 ? "icn_person_fill" : "icn_person")
                            Text("마이페이지")
                        }
                        .tag(3)
                        .disabled(authManager.isGuestMode)
                }
                .accentColor(.black)
            }
        }
    }
}

//#Preview {
//    MainTabView()
//        .environmentObject(AuthManager.shared)
//}
