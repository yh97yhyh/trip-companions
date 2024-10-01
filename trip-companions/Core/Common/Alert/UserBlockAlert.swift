//
//  UserBlockAlert.swift
//  trip-companions
//
//  Created by 영현 on 10/1/24.
//

import SwiftUI

struct UserBlockAlert: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("유저를 차단하시겠습니까?")
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("신고가 완료되었습니다.\n차단된 유저의 게시글은 더 이상 볼 수 없습니다.")
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
                        Text("아니요")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    showingAlert = false
//                    dismiss()
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
//    UserBlockAlert()
//}
