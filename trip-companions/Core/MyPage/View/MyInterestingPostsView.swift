//
//  MyInterestingPostsView.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import SwiftUI

struct MyInterestingPostsView: View {
    @StateObject var viewModel: MyInterestingPostsViewModel
    
    var body: some View {
        VStack {
            NavigationTitleView(title: "관심 있는 게시글")
                .padding(.horizontal)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("최신순")
                            .foregroundColor(.gray767676)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.myInterestingPosts, id: \.self) { tripCompanion in
                    VStack {
                        MyInterestingTripCompanionCellView(viewModel: MyInterestingTripCompanionCellViewModel(tripCompanion: tripCompanion))
                            .padding(.vertical, 12)
                    }
                    Divider()
                }
            }
            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyInterestingPostsView(viewModel: MyInterestingPostsViewModel.MOCK_VIEW_MODEL)
}
