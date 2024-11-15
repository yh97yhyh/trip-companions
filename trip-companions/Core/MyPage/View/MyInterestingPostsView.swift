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
                            let interestHeartViewModel = InterestHeartViewModel(tripCompanion: tripCompanion)
                            VStack {
                                NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion), interestHeartViewModel: InterestHeartViewModel(tripCompanion: tripCompanion))) {
                                    MyInterestingTripCompanionCellView(viewModel: MyInterestingTripCompanionCellViewModel(tripCompanion: tripCompanion), interestHeartViewModel: interestHeartViewModel)
                                }
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchTripCompanions()
        }
        .onDisappear {
            DomesticCompanionViewModel.shared.fetchTripCompanions()
        }
    }
}

#Preview {
    MyInterestingPostsView(viewModel: MyInterestingPostsViewModel.MOCK_VIEW_MODEL)
}
