//
//  NoMbtiAlertView.swift
//  trip-companions
//
//  Created by 영현 on 9/24/24.
//

import SwiftUI

struct NoMbtiAlertView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject private var viewModel = InfoCollectionViewModel.shared
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool
    @Binding var shouldNavigate: Bool

    var body: some View {
        VStack {
            HStack {
                Text("당신에 대해 더 알려주세요.")
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("MBTI를 기입해 주시면 당신과 더 잘 맞는\n여행 메이트를 찾을 수 있습니다.")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Button {
                    viewModel.updateMemberProfile { member in
                        authManager.currentMember = member
                        myPageViewModel.member = member
                    }
                    shouldNavigate = true
                    showingAlert = false
                } label: {
                    HStack {
                        Text("다음에 할게요")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    showingAlert = false
                } label: {
                    Text("확인")
                        .foregroundColor(.orangeF49321)
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    NoMbtiAlertView()
//}
