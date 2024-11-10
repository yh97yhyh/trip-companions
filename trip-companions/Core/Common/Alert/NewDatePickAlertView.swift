//
//  NewDatePickAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/3/24.
//

import SwiftUI

struct NewDatePickAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool

    var body: some View {
        VStack {
            HStack {
                Text("이전 날짜는 선택할 수 없습니다.\n다시 선택해 주세요.")
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Spacer()
                Button {
                    showingAlert = false
                } label: {
                    Text("확인")
                        .fontWeight(.bold)
                        .foregroundColor(.orangeF49321)
                }
                Spacer()
            }
            .padding(.top)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    NewDatePickAlertView()
//}
