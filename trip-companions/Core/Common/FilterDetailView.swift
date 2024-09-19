//
//  FilterDetailView.swift
//  trip-companions
//
//  Created by 영현 on 9/20/24.
//

import SwiftUI

struct FilterDetailView: View {
    var categoryId: Int
    
    var body: some View {
        VStack {
            Button {
                switch categoryId {
                case 1, 2:
                    SearchViewModel.shared.isSameMbti = nil
                case 3, 4:
                    SearchViewModel.shared.isMale = nil
                case 5, 6:
                    SearchViewModel.shared.isDrinker = nil
                case 7, 8:
                    SearchViewModel.shared.isSmoker = nil
                default:
                    SearchViewModel.shared.isSmoker = nil
                }
            } label: {
                HStack {
                    switch categoryId {
                    case 1:
                        Text("나와 같은 MBTI")
                    case 2:
                        Text("다른 MBTI도 좋아요")
                    case 3:
                        Text("남성")
                    case 4:
                        Text("여성")
                    case 5:
                        Text("음주")
                    case 6:
                        Text("논알콜")
                    case 7:
                        Text("흡연")
                    case 8:
                        Text("비흡연")
                    default:
                        Text("")
                    }
                    
                    Image(systemName: "xmark")
                }
                .font(.footnote)
                .foregroundColor(.gray767676)
            }
        }
        .padding(8)
        .background(.grayF5F6F8)
        .cornerRadius(48)
    }
}

#Preview {
    FilterDetailView(categoryId: 1)
}
