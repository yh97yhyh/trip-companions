//
//  SearchView.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var hasAppeared = false
    @State private var showingDatePicker = false
    var title: String
    
    @State var region: Region? = nil
    @State var startDate: Date? = nil
    @State var isSameMbti: Bool? = nil
    @State var isMale: Bool? = nil
    @State var isDrinker: Bool? = nil
    @State var isSmoker: Bool? = nil
    @State var keyword: String = ""
    
    var body: some View {
        VStack {
            NavigationTitleView(title: title)
                .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("어디로 떠나시나요?")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    NavigationLink(destination: SelectRegionView(viewModel: SelectRegionViewModel(), isInterestRegion: false, bindedRegion: $region)
                        .environmentObject(myPageViewModel)) {
                            HStack {
                                if region == nil {
                                    Text("지역명을 입력하세요")
                                } else {
                                    Text(region!.regionName)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                Image(systemName: "magnifyingglass")
                            }
                    }
                    .buttonStyle(SearchButtonStyle())
                    
                }
                .padding(.bottom, 24)
                
                VStack {
                    HStack {
                        Text("날짜 입력")
                            .font(.title3)
                        
                        Spacer()
                    }
                    
                    Button {
                        showingDatePicker = true
                    } label: {
                        HStack {
                            if startDate == nil {
                                Text("날짜를 입력하세요")
                            } else {
                                Text("\(startDate!.toDateText())")
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showingDatePicker) {
                        CustomDatePickerView(startDate: $startDate)
                    }
                    .buttonStyle(SearchButtonStyle())
                }
                .padding(.bottom, 24)
                
                VStack {
                    HStack {
                        Text("당신의 동행은?")
                            .font(.title3)
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            isSameMbti = isSameMbti == true ? nil : true
                        } label: {
                            Text("나와 같은 MBTI")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSameMbti == true))
                        
                        Button {
                            isSameMbti = isSameMbti == false ? nil : false
                        } label: {
                            Text("다른 MBTI도 좋아요")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSameMbti == false))
                        Spacer()
                    }
                    .padding(.horizontal, 1)
                    
                    HStack {
                        Button {
                            isMale = isMale == true ? nil : true
                        } label: {
                            Text("남성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isMale == true))
                        
                        Button {
                            isMale = isMale == false ? nil : false
                        } label: {
                            Text("여성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isMale == false))
                        Spacer()
                    }
                    .padding(.horizontal, 1)

                    HStack {
                        Button {
                            isDrinker = isDrinker == true ? nil : true
                        } label: {
                            Text("음주")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isDrinker == true))
                        
                        Button {
                            isDrinker = isDrinker == false ? nil : false
                        } label: {
                            Text("논알콜")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isDrinker == false))
                        Spacer()
                    }
                    .padding(.horizontal, 1)

                    HStack {
                        Button {
                            isSmoker = isSmoker == true ? nil : true
                        } label: {
                            Text("흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSmoker == true))
                        
                        Button {
                            isSmoker = isSmoker == false ? nil : false
                        } label: {
                            Text("비흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSmoker == false))
                        Spacer()
                    }
                    .padding(.horizontal, 1)
                }
                .padding(.bottom, 24)
                
            }
            .padding(.top)
            .padding(.horizontal)
            
            Button {
                viewModel.region = region
                viewModel.startDate = startDate
                viewModel.isSameMbti = isSameMbti
                viewModel.isMale = isMale
                viewModel.isDrinker = isDrinker
                viewModel.isSmoker = isSmoker
                viewModel.keyword = keyword
                DomesticCompanionViewModel.shared.fetchTripCompanions()
                MainTabViewModel.shared.selectedIndex = 1
                dismiss()
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
            .padding()
            .background(
                Color.white
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                    .mask(Rectangle().padding(.top, -20))
            )
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !hasAppeared { // dismiss 시에는 X
                self.region = viewModel.region
                self.startDate = viewModel.startDate
                self.isSameMbti = viewModel.isSameMbti
                self.isMale = viewModel.isMale
                self.isDrinker = viewModel.isDrinker
                self.isSmoker = viewModel.isSmoker
                self.keyword = viewModel.keyword
                
                hasAppeared = true
            }
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL, title: "검색")
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
