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
           NavigationView {
               List {
                   ForEach(viewModel.blockedUsers, id: \ .id) { user in
                       HStack {
                           Text(user.nickName ?? "")
                               .font(.headline)

                           Spacer()

                           Button(action: {
                               viewModel.unBlockUser(user)
                           }) {
                               Text("차단 해제")
                                   .font(.subheadline)
                                   .foregroundColor(.blue)
                           }
                           .buttonStyle(BorderlessButtonStyle())
                       }
                   }
               }
               .navigationTitle("차단된 회원")
               .onAppear {
                   viewModel.fetchBlcokedUsers()
               }
           }
       }
}

#Preview {
    MyBlockedUsersView(viewModel: MyBlockedUsersViewModel.MOCK_VIEW_MODEL)
}
