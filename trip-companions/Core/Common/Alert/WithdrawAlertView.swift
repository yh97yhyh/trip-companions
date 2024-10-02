//
//  WithdrawAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/1/24.
//

import SwiftUI

struct WithdrawAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("정말로 탈퇴하시겠습니까?")
                    .font(.title3)
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("탈퇴후 30일 간 재가입이 불가능합니다")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Button {
                    showingAlert = false
                } label: {
                    HStack {
                        Text("아니요")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    AuthManager.shared.withDraw()
                    showingAlert = false
                } label: {
                    Text("네")
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
//    WithdrawAlertView()
//}
