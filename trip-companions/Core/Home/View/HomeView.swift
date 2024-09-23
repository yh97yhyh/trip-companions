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
                    Text("여기는 어떠신가요?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    NavigationLink(destination: SelectRegionView(region: $viewModel.myRegion)) {
                        Text("지역 선택")
                            .foregroundColor(.grayA2A2A2)
                            .underline(true, color: .grayA2A2A2)
                    }
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
                    
                    Button {
                        MainTabViewModel.shared.selectedIndex = 1
                    } label: {
                        Image("btn_see_more")
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
    @State private var showAlert = false

    var body: some View {
        VStack {
            NavigationLink(destination: WriteTripCompanionView(isWriteMode: true, viewModel: WriteTripCompanionViewModel.shared)) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .padding(24)
                    .background(Color.orangeF49321)
                    .clipShape(Circle())
                    .onTapGesture {
                        if AuthManager.shared.isGuestMode {
                            showAlert = true
                        } else {
                            // Trigger navigation if not in guest mode
                            showAlert = false // This won't be used since NavigationLink handles it
                        }
                    }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Guest Mode"), message: Text("You cannot add a trip in guest mode."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
