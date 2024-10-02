//
//  CompleteUpdateAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/2/24.
//

import SwiftUI

struct CompleteUpdateAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("내 게시글이\n수정되었습니다.")
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Spacer()
                Button {
                    dismiss()
                    showingAlert = false
                } label: {
                    Text("닫기")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.top)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    CompleteUpdateAlertView()
//}
