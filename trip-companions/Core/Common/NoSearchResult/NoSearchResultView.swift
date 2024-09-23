//
//  NoSearchResultView.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import SwiftUI

struct NoSearchResultView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image("no_serach_result")
                        .padding()
                    Text("검색 결과가 없습니다.")
                        .padding(.bottom, 4)
                    Text("다른 검색어를 입력해 주세요.")
                        .font(.subheadline)
                        .foregroundColor(.grayA2A2A2)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    NoSearchResultView()
}
