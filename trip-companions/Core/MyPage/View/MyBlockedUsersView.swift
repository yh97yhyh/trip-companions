//
//  MyBlockedUsersView.swift
//  trip-companions
//
//  Created by 영현 on 1/15/25.
//

import SwiftUI

struct MyBlockedUsersView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: MyBlockedUsersViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView(title: "차단된 회원")
                .padding(.horizontal)
                .padding(.bottom)
            
            ScrollView(showsIndicators: false)  {
                LazyVStack {
                    ForEach(viewModel.blockedUsers, id: \ .id) { blockedUser in
                        VStack {
                            HStack {
                                Text(blockedUser.blockMember.nickName ?? "")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Button {
                                    viewModel.unBlockUser(blockedUser)
                                } label: {
                                    Text("차단 해제")
                                        .font(.subheadline)
                                }
                                .buttonStyle(MyPageButtonStyle())
                                .padding(2)
                            }
                            
                            Divider()
                            
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchBlcokedUsers()
        }
    }
}

#Preview {
    MyBlockedUsersView(viewModel: MyBlockedUsersViewModel.MOCK_VIEW_MODEL)
}
