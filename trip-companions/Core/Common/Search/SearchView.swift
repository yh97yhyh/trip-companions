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
    
    @State private var showingDatePicker = false
    var title: String
    
    var body: some View {
        VStack {
            NavigationTitleView(title: title)
                .padding(.horizontal)
            
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
                    
//                    NavigationLink(destination: CustomDatePickerView()) {
//                        HStack {
//                            Text("날짜를 입력하세요")
//                            Spacer()
//                        }
//                    }
//                    .buttonStyle(SearchButtonStyle())
                    
                    Button {
                        showingDatePicker = true
                    } label: {
                        HStack {
                            if viewModel.startDate == Date.defaultDate() && viewModel.endDate == Date.defaultDate() {
                                Text("날짜를 입력하세요")
                            } else {
                                Text("\(viewModel.startDate.toDateText()) ~ \(viewModel.endDate.toDateText())")
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showingDatePicker) {
                        CustomDatePickerView(startDate: $viewModel.startDate, endDate: $viewModel.endDate)
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
                            viewModel.isSameMbti = viewModel.isSameMbti == true ? nil : true
                        } label: {
                            Text("나와 같은 MBTI")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isSameMbti == true))
                        
                        Button {
                            viewModel.isSameMbti = viewModel.isSameMbti == false ? nil : false
                        } label: {
                            Text("다른 MBTI도 좋아요")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: viewModel.isSameMbti == false))
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
                
            }
            .padding(.top)
            .padding(.horizontal)
            
            Button {
                dismiss()
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL, title: "검색")
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
