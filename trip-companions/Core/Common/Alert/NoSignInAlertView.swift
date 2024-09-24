//
//  NoSignInAlertView.swift
//  trip-companions
//
//  Created by 영현 on 9/24/24.
//

import SwiftUI

struct NoSignInAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("가입이 필요합니다.")
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("로그인 후 이용 가능합니다.\n가입하시겠습니까?")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Button {
                    showingAlert = false
//                    dismiss()
                } label: {
                    HStack {
                        Text("다음에 할게요")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    AuthManager.shared.isGuestMode = false
//                    dismiss()
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
//    NoSignInAlertView(isShowingAlert: <#Binding<Bool>#>)
//}

