//
//  DeletedUserAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/2/24.
//

import SwiftUI

struct DeletedUserAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("게시물을 찾을 수 없습니다.")
                    .font(.title3)
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("이미 삭제된 게시물입니다.")
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
                    Text("네")
                        .foregroundColor(.orangeF49321)
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    DeletedUserAlertView()
//}
