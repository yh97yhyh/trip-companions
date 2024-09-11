//
//  MyPostsView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI

struct MyPostsView: View {
    @StateObject var viewModel: MyPostsViewModel
    
    var body: some View {
        VStack {
            NavigationTitleView(title: "내 게시글 관리")
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
                ForEach(viewModel.myPosts, id: \.self) { tripCompanion in
                    // MARK: - Update MyCompanionCellView
                    VStack {
                        MyTripCompanionCellView(viewModel: MyTripCompanionCellViewModel(tripCompanion: tripCompanion))
                            .padding(.vertical, 12)
//                        HStack {
//                            Button {
//                                
//                            } label: {
//                                Text("수정")
//                                    .font(.subheadline)
//                            }
//                            .buttonStyle(MyPageButtonStyle())
//                            
//                            Button {
//                                
//                            } label: {
//                                Text("삭제")
//                                    .font(.subheadline)
//                            }
//                            .buttonStyle(MyPageButtonStyle())
//                            
//                            Spacer()
//                        }
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

//#Preview {
//    MyPostsView(viewModel: MyPostsViewModel.MOCK_VIEW_MODEL)
//}
