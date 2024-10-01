//
//  ReportAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/2/24.
//

import SwiftUI

struct ReportAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool
    @Binding var showingBlockAlert: Bool
    @State private var selectedOption: ToggleOption? = nil

    var body: some View {
        VStack {
            HStack {
                Text("신고 사유를 선택해 주세요")
                    .font(.title3)
                    .padding(.bottom)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                ForEach(ToggleOption.allCases, id: \.self) { option in
                    HStack {
                        Toggle(option.title, isOn: Binding(
                            get: {
                                selectedOption == option
                            },
                            set: { isSelected in
                                if isSelected {
                                    selectedOption = option
                                } else {
                                    selectedOption = nil
                                }
                            }
                        ))
                        .toggleStyle(CheckboxToggleStyle(style: .circle))
                        Spacer()
                    }
                    .padding(.bottom, 8)
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            HStack {
                Text("허위 신고시 제재를 받을 수 있습니다.")
                    .font(.subheadline)
                    .foregroundColor(.gray999999)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Divider()
            
            HStack {
                Button {
                    showingAlert = false
                } label: {
                    HStack {
                        Text("닫기")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    showingAlert = false
                    showingBlockAlert = true
                } label: {
                    Text("신고하기")
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

enum ToggleOption: Int, CaseIterable {
    case option1, option2, option3, option4, option5
    
    var title: String {
        switch self {
        case .option1: return "광고성 게시물"
        case .option2: return "욕설"
        case .option3: return "음란물"
        case .option4: return "스팸/도배"
        case .option5: return "불법적인 정보 포함"
        }
    }
}

//#Preview {
//    ReportAlertView()
//}
