//
//  HomeView.swift
//  trip-companions
//
//  Created by 영현 on 8/7/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ProfileHeaderView(viewModel: ProfileHeaderViewModel(isShowingProfileUpdateButton: true))
                .padding(.bottom)
            
            DividerView()
                .padding(.horizontal, -16)
                .padding(.bottom)
            
            NavigationLink(destination: SearchView(viewModel: SearchViewModel.shared, title: "검색")) {
                HStack {
                    Text("어디로 가시나요?")
                    Spacer()
                    Image(systemName: "magnifyingglass")
                }
            }
            .buttonStyle(TripSearchButtonStyle())
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("여기는 어떠신가요?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .padding(.bottom)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                        NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion))) {
                            HomeTripCompanionCellView(viewModel: HomeTripCompanionCellViewModel(tripCompanion: tripCompanion))
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                                .padding(.trailing, 2)
                        }
                    }
                }
                .padding(4)
            }
            Spacer()
            
            HStack {
                Spacer()
                HomeAddButtonView()
                    .padding(.bottom, 32)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeAddButtonView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: WriteTripCompanionView(viewModel: WriteTripCompanionViewModel.shared)) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(24)
                    .background(Color.orangeF49321)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
