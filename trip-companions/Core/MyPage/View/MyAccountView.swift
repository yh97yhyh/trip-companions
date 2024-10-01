//
//  MyAccountView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI

struct MyAccountView: View {
//    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: MyAccountViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView(title: "계정 확인")
                .padding(.horizontal)
                .padding(.bottom)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("카카오 계정")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        Text("연결됨")
                            .foregroundColor(.grayA2A2A2)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("연동 해제")
                    }
                    .buttonStyle(MyPageButtonStyle())
                }
                
                Divider()
                    .padding(.bottom, 8)
                    .padding(.top, 8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("이메일")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        Text(myPageViewModel.member.email)
                            .foregroundColor(.grayA2A2A2)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("변경")
                    }
                    .buttonStyle(MyPageButtonStyle())
                }
                
                Divider()
                    .padding(.bottom, 8)
                    .padding(.top, 8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("전화번호")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        Text(viewModel.toNumberFormat(myPageViewModel.member.phoneNumber ?? ""))
                            .foregroundColor(.grayA2A2A2)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("변경")
                    }
                    .buttonStyle(MyPageButtonStyle())
                }
                
                Divider()
                    .padding(.bottom, 8)
                    .padding(.top, 8)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyAccountView(viewModel: MyAccountViewModel())
//        .environmentObject(AuthManager.shared)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
