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
//    @State var regionName: String = ""
//    @State var date: Date = Date()
//    @State var isMale: Bool? = nil
//    @State var isDrinker: Bool? = nil
//    @State var isSmoker: Bool? = nil
//    @State var detail: String = ""
    
    var body: some View {
        VStack {
            NavigationTitleView()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        // MARK: - Add Image(systemName: "magnifyingglass")
                        Text("여기는 어떠신가요?")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextField("지역명을 입력하세요", text: $viewModel.regionName)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                }
                .padding(.bottom, 24)

                VStack {
                    HStack {
                        Text("날짜 입력")
                            .font(.title3)
                        
                        Spacer()
                    }
                    
                    NavigationLink(destination: CustomDatePickerView()) {
                        HStack {
                            Text("날짜를 입력하세요")
                            Spacer()
                        }
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
                            viewModel.isMale = viewModel.isMale == true ? nil : true
                        } label: {
                            Text("남성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isMale == true))
                        
                        Button {
                            viewModel.isMale = viewModel.isMale == false ? nil : false
                        } label: {
                            Text("여성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isMale == false))
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            viewModel.isDrinker = viewModel.isDrinker == true ? nil : true
                        } label: {
                            Text("음주")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isDrinker == true))
                        
                        Button {
                            viewModel.isDrinker = viewModel.isDrinker == false ? nil : false
                        } label: {
                            Text("논알콜")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isDrinker == false))
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            viewModel.isSmoker = viewModel.isSmoker == true ? nil : true
                        } label: {
                            Text("흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isSmoker == true))
                        
                        Button {
                            viewModel.isSmoker = viewModel.isSmoker == false ? nil : false
                        } label: {
                            Text("비흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isSmoker == false))
                        Spacer()
                    }
                }
                .padding(.bottom, 24)
                
                VStack {
                    HStack {
                        // MARK: - Add Image(systemName: "magnifyingglass")
                        Text("세부 조건")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextField("조건 입력", text: $viewModel.detail)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    
                    // MARK: - Add options
                }
            }
            .padding(.top)
//            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
            
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
