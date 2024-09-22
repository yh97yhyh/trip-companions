//
//  SelectRegionView.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import SwiftUI

struct SelectRegionView: View {
    @Binding var region: Region?
    @State var selectRegion: Region?
    @State var regionKeyword = "" {
        didSet {
            filterRegions()
        }
    }
    @State var filteredRegions = MetaDataViewModel.shared.regions
    @Environment(\.dismiss) private var dismiss
    
    func filterRegions() {
        if regionKeyword.isEmpty {
            filteredRegions = MetaDataViewModel.shared.regions
        } else {
            filteredRegions = MetaDataViewModel.shared.regions.filter { region in
                return region.regionName.lowercased().contains(regionKeyword.lowercased())
            }
        }
    }
    
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
                
                TextField("지역을 입력하세요", text: $regionKeyword)
                    .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    .onChange(of: regionKeyword) { newValue in
                        filterRegions()
                        if newValue == "" {
                            selectRegion = nil
                        }
                    }
            }
            
            if filteredRegions.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Image("no_serach_result")
                            .padding()
                        Text("지역 검색 결과가 없습니다.")
                            .padding(.bottom, 4)
                        Text("다른 검색어를 입력해 주세요.")
                            .font(.subheadline)
                            .foregroundColor(.grayA2A2A2)
                    }
                    Spacer()
                }
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(filteredRegions, id: \.id) { region in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(region.regionName)
                                Spacer()
                            }
                            .tag(region as Region)
                            .padding(.bottom, 8)
                            .onTapGesture {
                                regionKeyword = region.regionName
                                selectRegion = region
                            }
                        }
                    }
                }
                .padding(.top, 24)
            }
            
            Button {
                region = selectRegion
                HomeViewModel.shared.fetchRecommendedTripCompanions()
                dismiss()
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: selectRegion != nil))
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onDisappear {
//            regionKeyword = ""
//            selectRegion = nil
        }
    }
}

//#Preview {
//    SelectRegionView()
//}
