//
//  CustomDatePickerView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @State var startDate = Date()
    @State var endDate = Date()

    var body: some View {
        VStack {
            HStack {
                Text("날짜 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.gray999999)
                }
            }
            .padding(.bottom)
            
            Divider()
                .padding(.bottom)
            
            // MARK: - Add DatePicker
            
            Spacer()
            
            Button {
                
            } label: {
                Text("날짜 선택 완료")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CustomDatePickerView()
}
