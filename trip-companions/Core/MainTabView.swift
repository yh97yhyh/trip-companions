//
//  MainTabView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                
                TabView(selection: $selectedIndex) {
                    DomesticCompanionView()
                        .onAppear {
                            selectedIndex = 0
                        }
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                            Text("국내 동행")
                        }
                        .tag(0)
                    OverseaCompanionView()
                        .onAppear {
                            selectedIndex = 1
                        }
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("해외 동행")
                        }
                        .tag(1)
                    HomeView()
                        .onAppear {
                            selectedIndex = 2
                        }
                        .tabItem {
                            Image(systemName: "house")
                            Text("홈")
                        }
                        .tag(2)
                    MyPageView()
                        .onAppear {
                            selectedIndex = 3
                        }
                        .tabItem {
                            Image(systemName: "person")
                            Text("마이페이지")
                        }
                        .tag(3)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
