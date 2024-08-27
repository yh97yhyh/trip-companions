//
//  MyPageView.swift
//  trip-companions
//
//  Created by 영현 on 8/7/24.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("마이페이지")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical)
            
            ProfileHeaderView(viewModel: ProfileHeaderViewModel(isShowingProfileUpdateButton: false))
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("계정 설정")
                    .foregroundColor(.grayA2A2A2)
                    .padding(.bottom)
                
                Text("프로필 관리")
//                    .fontWeight(.semibold)
                    .padding(.bottom)
                
                Text("계정 확인")
//                    .fontWeight(.semibold)
                    .padding(.bottom)
            }
            
            Divider()
                .padding(.bottom)
            
            Text("내 게시글 관리")
            
            
            

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    MyPageView()
        .environmentObject(AuthManager.shared)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
