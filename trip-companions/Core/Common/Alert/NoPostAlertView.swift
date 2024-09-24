//
//  NoPostAlertView.swift
//  trip-companions
//
//  Created by 영현 on 9/24/24.
//

import SwiftUI

struct NoPostAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("게시물을 찾을 수 없습니다.")
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
            
            Button {
                showingAlert = false
//                dismiss()
            } label: {
                Text("다음에 할게요")
                    .foregroundColor(.orangeF49321)
                    .fontWeight(.bold)
            }
            .padding(.top)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    NoPostAlertView()
//}
