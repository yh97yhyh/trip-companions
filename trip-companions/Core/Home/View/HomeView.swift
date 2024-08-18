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
        ZStack {
            VStack {
                ProfileHeaderView(viewModel: ProfileHeaderViewModel(member: .MOCK_MEMBER1, isShowingProfileUpdateButton: true))
                    .padding(.bottom)
                
                DividerView()
                    .padding(.horizontal, -16)
                    .padding(.bottom)
                
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: SearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL)) {
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
                        
                        ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                            NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion))) {
                                TripCompanionCellView(viewModel: TripCompanionCellViewModel(tripCompanion: tripCompanion, thumbnail: nil))
                                    .padding(.vertical, 12)
                            }
                            Divider()
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddButtonView()
                        .padding(.bottom, 32)
                }
            }
            
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct AddButtonView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: WriteTripCompanionView(viewModel: WriteTripCompanionViewModel.MOCK_VIEW_MODEL)) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(24)
                    .background(Color.orangeF49321)
                    .clipShape(Circle())
            }
//            // MARK: - Update to NavigationLink
//            Button {
//                
//            } label: {
//                Image(systemName: "plus")
//                    .imageScale(.large)
//                    .foregroundColor(.white)
//                    .padding(24)
//                    .background(Color.orangeF49321)
//                    .clipShape(Circle())
//                
//            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
