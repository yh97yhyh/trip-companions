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
    @State var mockRegion: Region?
    @State var showingNoSignInAlert = false
    @State var showingDeletedPostAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                ProfileHeaderView(viewModel: ProfileHeaderViewModel(isShowingProfileUpdateButton: true))
                    .padding(.bottom)
                
                DividerView()
                    .padding(.horizontal, -16)
                    .padding(.bottom)
                
                NavigationLink(destination: HomeSearchView(viewModel: SearchViewModel.shared)) {
                    HStack {
                        Text("검색어를 입력하세요.")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }
                }
                .buttonStyle(TripSearchButtonStyle())
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    HStack {
                        if AuthManager.shared.isGuestMode {
                            Text("어디로 떠나시나요?")
                                .font(.title3)
                                .fontWeight(.semibold)
                        } else {
                            Text("\(myPageViewModel.member.interestRegion?.regionName ?? "")")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.orangeF49321) +
                            Text(" 여행 계획중이에요")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        
                        if AuthManager.shared.isGuestMode {
                            Button {
                                showingNoSignInAlert = true
                            } label: {
                                Text("지역 선택")
                                    .foregroundColor(.grayA2A2A2)
                                    .underline(true, color: .grayA2A2A2)
                            }
                        } else {
                            NavigationLink(destination: SelectRegionView(viewModel: SelectRegionViewModel(), bindedRegion: $mockRegion)) {
                                Text("지역 선택")
                                    .foregroundColor(.grayA2A2A2)
                                    .underline(true, color: .grayA2A2A2)
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                if viewModel.isFetching {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    Spacer()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                                let interestHeartViewModel = InterestHeartViewModel(tripCompanion: tripCompanion)
                                NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion), interestHeartViewModel: interestHeartViewModel)) {
                                    HomeTripCompanionCellView(viewModel: HomeTripCompanionCellViewModel(tripCompanion: tripCompanion), interestHeartViewModel: interestHeartViewModel)
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(10)
                                        .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                                        .padding(.trailing, 2)
                                        .frame(minWidth: 200)
                                }
                            }
                            
                            Button {
                                MainTabViewModel.shared.selectedIndex = 1
                            } label: {
                                Image("btn_see_more")
                            }
                            
                        }
                        .padding(4)
                        
                    }
                    .refreshable {
                        viewModel.fetchRecommendedTripCompanions()
                    }
                }
                Spacer()
                
                HStack {
                    Spacer()
                    WriteButtonView(showingNoSignInAlert: $showingNoSignInAlert)
                        .padding(.bottom, 32)
                }
            }
            .padding()
            
            if showingNoSignInAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                NoSignInAlertView(showingAlert: $showingNoSignInAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel.MOCK_VIEW_MODEL, showingNoSignInAlert: false)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
