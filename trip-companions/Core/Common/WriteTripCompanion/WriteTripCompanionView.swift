//
//  WriteTripCompanionView.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import SwiftUI

struct WriteTripCompanionView: View {
    var isWriteMode: Bool
    var tripCompanion: TripCompanion?
    @StateObject var viewModel: WriteTripCompanionViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingDatePicker = false
    
//    init(viewModel: WriteTripCompanionViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        UITextView.appearance().backgroundColor = .clear
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationTitleView(title: isWriteMode ? "동행등록" : "동행등록 수정")
                .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    HStack {
                        HStack {
                            Image("icn_location")
                            Text("지역")
                                .font(.callout)
                        }
                        .padding(.trailing, 56)
                        Spacer()
                        
                        Menu {
                            ForEach(MetaDataViewModel.shared.regions, id: \.self) { region in
                                Button {
                                    viewModel.region = region
                                } label: {
                                    VStack {
                                        Text(region.regionName)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                if viewModel.region == nil {
                                    Text("지역 찾기")
                                } else {
                                    Text(viewModel.region!.regionName)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }
                        }
                        .buttonStyle(SearchButtonStyle())
                    }
                    
                    Button {
                        showingDatePicker = true
                    } label: {
                        HStack {
                            if viewModel.startDate == nil {
                                Text("날짜를 입력하세요")
                            } else {
                                Text("\(viewModel.startDate!.toDateText())")
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showingDatePicker) {
                        CustomDatePickerView(startDate: $viewModel.startDate)
                    }
                    .buttonStyle(SearchButtonStyle())
                    
                    TextField("모집 인원", text: $viewModel.personal)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                        .keyboardType(.numberPad)
                    
                    TextField("제목", text: $viewModel.title)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                    
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
                    .padding(.bottom)
                }
            }
            .padding()
            
            Button {
                if isWriteMode {
                    viewModel.createTripCompanion()
                } else {
                    if let postId = tripCompanion?.id {
                        viewModel.updateTripCompanion(postId: postId)
                    }
                }
                dismiss()
            } label: {
                Text("등록하기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if tripCompanion != nil {
                viewModel.region = tripCompanion!.region
                viewModel.startDate = tripCompanion!.tripDate.toDate()
                viewModel.personal = String(tripCompanion!.companionMemberCount)
                viewModel.title = tripCompanion!.title
                viewModel.contents = tripCompanion!.contents
                
                for category in tripCompanion!.categories {
                    switch category.id {
                    case 1:
                        viewModel.isSameMbti = true
                    case 2:
                        viewModel.isSameMbti = false
                    case 3:
                        viewModel.isMale = true
                    case 4:
                        viewModel.isMale = false
                    case 5:
                        viewModel.isDrinker = true
                    case 6:
                        viewModel.isDrinker = false
                    case 7:
                        viewModel.isSmoker = true
                    case 8:
                        viewModel.isSmoker = false
                    default:
                        continue
                    }
                }
            }
        }
        .onDisappear {
            viewModel.clear()
        }
        
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

//#Preview {
//    WriteTripCompanionView(isWriteMode: false, viewModel: WriteTripCompanionViewModel.MOCK_VIEW_MODEL)
//}
