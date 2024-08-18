//
//  WriteTripCompanionView.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import SwiftUI

struct WriteTripCompanionView: View {
    @StateObject var viewModel: WriteTripCompanionViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingDatePicker = false
    
//    init(viewModel: WriteTripCompanionViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        UITextView.appearance().backgroundColor = .clear
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView()
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("동행 등록")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.bottom)
                
                HStack {
                    HStack {
                        Image(systemName: "location")
                        Text("지역")
                            .font(.callout)
                    }
                    .padding(.trailing, 56)
                    Spacer()
                    //MARK: - 지역 검색
                    NavigationLink(destination: Text("동읍면찾기")) {
                        HStack {
                            Text("동.읍.면 찾기")
                            Spacer()
                        }
                    }
                    .buttonStyle(SearchButtonStyle())
                }
                
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
                
                TextField("모집 인원", text: $viewModel.region)
                    .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    .keyboardType(.numberPad)
                
                ContentsTextEditor(viewModel: viewModel)
                    .padding(.bottom)
                
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
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Text("세부 조건")
                            .font(.title3)
                        Spacer()
                    }
                    
                    TextField("조건 입력", text: $viewModel.detail)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    
                    // MARK: - Add options
                }
                
            }
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("등록하기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentsTextEditor: View {
    @StateObject var viewModel: WriteTripCompanionViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $viewModel.contents)
                .font(.subheadline)
                .padding(16)
                .frame(height: 150)
                .background(Color.grayF5F6F8)
                .cornerRadius(6)
                .scrollContentBackground(.hidden)
            
            if viewModel.contents.isEmpty {
                Text("상세 내용을 입력하세요")
                    .font(.subheadline)
                    .foregroundColor(Color.primary.opacity(0.25))
//                    .lineSpacing(10)
                    .padding(.top, 20)
                    .padding(.leading, 19)
            }
        }
    }
}

#Preview {
    WriteTripCompanionView(viewModel: WriteTripCompanionViewModel.MOCK_VIEW_MODEL)
}
