//
//  InterestHeartView.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import SwiftUI

struct InterestHeartView: View {
    var isDetail: Bool
    var isInterest: Bool
    var inerestCount: Int
    
    var body: some View {
        VStack {
            if isDetail {
                VStack {
                    if isInterest {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")                            .foregroundColor(.gray767676)
                    }
                    Text("\(inerestCount)")
                        .foregroundColor(.gray767676)
                        .font(.subheadline)
                }
            } else {
                HStack {
                    if isInterest {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray767676)
                    }
                    Text("\(inerestCount)")
                        .foregroundColor(.gray767676)
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    InterestHeartView(isDetail: true, isInterest: true, inerestCount: 127)
}
