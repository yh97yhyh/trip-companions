//
//  MyPostsView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI

struct MyPostsView: View {
    @StateObject var viewModel: MyPostsViewModel
    @State var showingPostDeleteAlert = false
    @State var deletePostId: Int?
    
    var body: some View {
        ZStack {
            VStack {
                NavigationTitleView(title: "내 게시글 관리")
                    .padding(.horizontal)
                
                VStack {
                    HStack {
                        Spacer()
                        //                    Button {
                        //
                        //                    } label: {
                        //                        Text("최신순")
                        //                            .foregroundColor(.gray767676)
                        //                    }
                        Text("최신순")
                            .foregroundColor(.gray767676)
                    }
                    Divider()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                                VStack {
                                    MyTripCompanionCellView(viewModel: MyTripCompanionCellViewModel(tripCompanion: tripCompanion), showingPostDeleteAlert: $showingPostDeleteAlert, postId: $deletePostId)
                                        .padding(.vertical, 12)
                                }
                                Divider()
                            }
                            if viewModel.page < viewModel.totalPage && !viewModel.isFetching {
                                ProgressView()
                                    .onAppear {
                                        viewModel.addTripCompanions()
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .refreshable {
                        viewModel.fetchTripCompanions()
                    }
                }
                
            }
            
            if showingPostDeleteAlert && deletePostId != nil {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                PostDeleteAlertView(showingAlert: $showingPostDeleteAlert, postId: deletePostId!)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchTripCompanions()
        }
    }
}

#Preview {
    MyPostsView(viewModel: MyPostsViewModel.MOCK_VIEW_MODEL)
}
