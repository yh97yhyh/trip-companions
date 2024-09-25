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
    @State private var showingNoSignInAlert = false // 알림을 관리하는 상태 변수
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("국내동행")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.trailing, 12)
                    
                    TextField("검색어를 입력하세요.", text: $searchViewModel.keyword)
                        .frame(height: 24)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false, paddingSize: 12))
                        .onSubmit {
                            viewModel.fetchTripCompanions()
                        }
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
                    .padding(.trailing, 18)
                    
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
                .padding(.bottom, 12)
                
                DividerView()
                    .padding(.horizontal, -16)
                
                if viewModel.tripCompanions.isEmpty {
                    if viewModel.isFetching {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        Spacer()
                    } else {
                        NoSearchResultView()
                    }
                } else {
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
            }
            .padding()
            
            VStack {
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


private var loadingView: some View {
    ProgressView()
}

//#Preview {
//    DomesticCompanionView(viewModel: DomesticCompanionViewModel.MOCK_VIEW_MODEL, searchViewModel: SearchViewModel.MOCK_VIEW_MODEL)
//}
