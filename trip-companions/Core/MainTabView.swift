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
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                TabView(selection: $selectedIndex) {
                    HomeView(viewModel: HomeViewModel.shared)
                        .onAppear {
                            selectedIndex = 0
                        }
                        .tabItem {
                            Image(selectedIndex == 0 ? "icn_home_fill" : "icn_home")
                            Text("홈")
                        }
                        .tag(0)
                    DomesticCompanionView(viewModel: DomesticCompanionViewModel.MOCK_VIEW_MODEL)
                        .onAppear {
                            selectedIndex = 1
                        }
                        .tabItem {
                            Image(selectedIndex == 1 ? "icn_domestic_fill" : "icn_domestic")
                            Text("국내 동행")
                        }
                        .tag(1)
                    OverseaCompanionView()
                        .onAppear {
                            selectedIndex = 2
                        }
                        .tabItem {
                            Image(selectedIndex == 2 ? "icn_oversea_fill" : "icn_oversea")
                            Text("해외 동행")
                        }
                        .tag(2)
                    MyPageView()
                        .onAppear {
                            selectedIndex = 3
                        }
                        .tabItem {
                            Image(selectedIndex == 3 ? "icn_person_fill" : "icn_person")
                            Text("마이페이지")
                        }
                        .tag(3)
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
