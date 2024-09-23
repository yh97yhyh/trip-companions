//
//  HomeSearchView.swift
//  trip-companions
//
//  Created by 영현 on 9/23/24.
//

import SwiftUI

struct HomeSearchView: View {
    @StateObject var viewModel: SearchViewModel
    @State private var showingDatePicker = false
    @Environment(\.dismiss) private var dismiss
    
    @State var keyword: String = ""
    @State var startDate: Date? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView(title: "검색")
                .padding(.bottom)
            
            VStack {
                HStack {
                    Text("검색어를 입력하세요.")
                        .font(.title3)
                    
                    Spacer()
                }
                
                TextField("예) 제주도, 여자 등", text: $keyword)
                    .textFieldStyle(CustomTextFieldStyle(isEditing: false))
            }
            .padding(.bottom, 32)
            
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
            
            Spacer()
            
            Button {
                viewModel.keyword = keyword
                viewModel.startDate = startDate
                MainTabViewModel.shared.selectedIndex = 1
                dismiss()
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: keyword != ""))
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.keyword = viewModel.keyword
            self.startDate = viewModel.startDate
        }
    }
}

#Preview {
    HomeSearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL)
}
