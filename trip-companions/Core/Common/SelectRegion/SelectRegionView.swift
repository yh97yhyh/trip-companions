//
//  SelectRegionView.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import SwiftUI

struct SelectRegionView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: SelectRegionViewModel
    
    var isInterestRegion = true
    @Binding var bindedRegion: Region?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView(title: "지역 선택")
                .padding(.bottom)
            
            VStack {
                HStack {
                    Text("어디로 떠나시나요?")
                        .font(.title3)
                    
                    Spacer()
                }
                
                TextField("지역을 입력하세요", text: $viewModel.regionKeyword)
                    .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    .onChange(of: viewModel.regionKeyword) { newValue in
                        viewModel.filterRegions()
                        if newValue == "" {
                            viewModel.region = nil
                        }
                    }
            }
            
            if viewModel.filteredRegions.isEmpty {
                NoSearchResultView()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.filteredRegions, id: \.id) { region in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(region.regionName)
                                Spacer()
                            }
                            .tag(region as Region)
                            .padding(.bottom, 8)
                            .onTapGesture {
                                viewModel.regionKeyword = region.regionName
                                viewModel.region = region
                            }
                        }
                    }
                }
                .padding(.top, 24)
            }
            
            Button {
                if isInterestRegion {
                    viewModel.updateInterestRegion { member in
                        authManager.currentMember = member
                        myPageViewModel.member = member
                        HomeViewModel.shared.fetchRecommendedTripCompanions()
                    }
                } else {
                    bindedRegion = viewModel.region
                }
                dismiss()
            } label: {
                Text("등록하기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: viewModel.region != nil))
            .disabled(viewModel.region == nil)
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let region = SearchViewModel.shared.region {
                viewModel.region = region
            }
        }
    }
}

//#Preview {
//    SelectRegionView()
//}
