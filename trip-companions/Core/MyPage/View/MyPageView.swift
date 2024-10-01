//
//  MyPageView.swift
//  trip-companions
//
//  Created by 영현 on 8/7/24.
//

import SwiftUI

struct MyPageView: View {
//    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @State var showingWithdrawAlert = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("마이페이지")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.vertical)
                
                ProfileHeaderView(viewModel: ProfileHeaderViewModel(isShowingProfileUpdateButton: false))
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                    .padding(.bottom, 56)
                
                //            VStack(alignment: .leading) {
                //                Text("계정 설정")
                //                    .foregroundColor(.grayA2A2A2)
                //                    .padding(.bottom)
                
                
                NavigationLink(destination: InfoCollectionView(isEditMode: true)) {
                    Text("프로필 관리")
                        .foregroundColor(.black)
                }
                .padding(.bottom)
                
                //                NavigationLink(destination: MyAccountView(viewModel: MyAccountViewModel())) {
                //                    Text("계정 확인")
                //                        .foregroundColor(.black)
                //                }
                //                .padding(.bottom)
                //            }
                
                Divider()
                    .padding(.bottom)
                
                NavigationLink(destination: MyPostsView(viewModel: MyPostsViewModel.shared)) {
                    Text("내 게시글 관리")
                        .foregroundColor(.black)
                }
                .padding(.bottom)
                
                Divider()
                    .padding(.bottom)
                
                NavigationLink(destination: MyInterestingPostsView(viewModel: MyInterestingPostsViewModel.shared)) {
                    Text("관심 있는 게시글")
                        .foregroundColor(.black)
                }
                .padding(.bottom)
                
                Divider()
                    .padding(.bottom)
                
                Button {
                    showingWithdrawAlert = true
                } label: {
                    Text("회원 탈퇴")
                        .foregroundColor(.black)
                    
                }
                .padding(.bottom)
                
                Divider()
                    .padding(.bottom)
                
                
                Spacer()
            }
            .padding(.horizontal)
            
            if showingWithdrawAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                WithdrawAlertView(showingAlert: $showingWithdrawAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
    }
}

#Preview {
    MyPageView()
//        .environmentObject(AuthManager.shared)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
