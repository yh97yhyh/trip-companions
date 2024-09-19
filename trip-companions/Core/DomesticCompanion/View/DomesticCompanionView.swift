//
//  DomesticCompanionView.swift
//  trip-companions
//
//  Created by 영현 on 8/7/24.
//

import SwiftUI

struct DomesticCompanionView: View {
    @StateObject var viewModel: DomesticCompanionViewModel
    @StateObject var searchViewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("국내동행")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.bottom)
                
                HStack {
                    HStack {
                        NavigationLink(destination: SearchView(viewModel: searchViewModel, title: "필터")) {
                            Image(systemName: "slider.horizontal.3")
                            Text("필터")
                        }
                        .foregroundColor(.black)
                    }
                    .fontWeight(.semibold)
                    
                    // MARK: - Update to add options
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let region = searchViewModel.region {
                                Button {
                                    searchViewModel.region = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(region.regionName)
                                        Image(systemName: "xmark")
                                    }
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                            
                            if let startDate = searchViewModel.startDate {
                                Button {
                                    searchViewModel.startDate = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(startDate.toDateText())
                                        Image(systemName: "xmark")
                                    }
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                            
                            if let isSameMbti = searchViewModel.isSameMbti {
                                Button {
                                    searchViewModel.isSameMbti = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(isSameMbti ? "나와 같은 MBTI" : "다른 MBTI도 좋아요")
                                        Image(systemName: "xmark")
                                    }
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                            
                            if let isMale = searchViewModel.isMale {
                                Button {
                                    searchViewModel.isMale = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(isMale ? "남성" : "여성")
                                        Image(systemName: "xmark")
                                    }
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                            
                            if let isDrinker = searchViewModel.isDrinker {
                                Button {
                                    searchViewModel.isDrinker = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(isDrinker ? "음주" : "논알콜")
                                        Image(systemName: "xmark")
                                    }
                                        
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                            
                            if let isSmoker = searchViewModel.isSmoker {
                                Button {
                                    searchViewModel.isSmoker = nil
                                    viewModel.fetchTripCompanions()
                                } label: {
                                    HStack {
                                        Text(isSmoker ? "흡연" : "비흡연")
                                        Image(systemName: "xmark")
                                    }
                                }
                                .buttonStyle(FilterButtonStyle())
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                DividerView()
                    .padding(.horizontal, -16)
                
                VStack(alignment: .leading) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                                NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion))) {
                                    TripCompanionCellView(viewModel: TripCompanionCellViewModel(tripCompanion: tripCompanion))
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
                    .refreshable {
                        viewModel.fetchTripCompanions()
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    DomesticAddButtonView()
                        .padding(.bottom, 32)
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DomesticAddButtonView: View {
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

private var loadingView: some View {
  ProgressView()
}

//#Preview {
//    DomesticCompanionView(viewModel: DomesticCompanionViewModel.MOCK_VIEW_MODEL, searchViewModel: SearchViewModel.MOCK_VIEW_MODEL)
//}
