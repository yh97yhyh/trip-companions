//
//  InterestHeartView.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import SwiftUI

struct InterestHeartView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: InterestHeartViewModel
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
                            .onTapGesture {
                                viewModel.toggleLike(writer: myPageViewModel.member, isLike: false)
                            }
                    } else {
                        Image(systemName: "heart") 
                            .foregroundColor(.gray767676)
                            .onTapGesture {
                                viewModel.toggleLike(writer: myPageViewModel.member, isLike: true)
                            }
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
                            .onTapGesture {
                                viewModel.toggleLike(writer: myPageViewModel.member, isLike: false)
                            }
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray767676)
                            .onTapGesture {
                                viewModel.toggleLike(writer: myPageViewModel.member, isLike: true)
                            }
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
    InterestHeartView(viewModel: InterestHeartViewModel.MOCK_VIEW_MODEL, isDetail: true, isInterest: true, inerestCount: 127)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
