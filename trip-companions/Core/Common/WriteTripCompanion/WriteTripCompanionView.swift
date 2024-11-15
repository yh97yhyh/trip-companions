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
    @State var showingCompleteUpdateAlert = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                NavigationTitleView(title: isWriteMode ? "동행등록" : "동행등록 수정")
                    .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        HStack {
                            HStack {
                                Image("icn_location_write")
                                Text("지역")
                                    .font(.callout)
                            }
                            .padding(.trailing, 56)
                            Spacer()
                            
                            NavigationLink(destination: SelectRegionView(viewModel: SelectRegionViewModel(), isInterestRegion: false, bindedRegion: $viewModel.region)) {
                                HStack {
                                    if viewModel.region == nil {
                                        Text("지역 선택")
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
                                Text("동행과 안전하게 소통해요.")
                                    .font(.title3)
                                
                                Spacer()
                            }
                            
                            TextField("카카오 오픈채팅 url 입력", text: $viewModel.openKakaoUrl)
                                .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                        }
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
                            .padding(.horizontal, 1)
                            
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
                            .padding(.horizontal, 1)
                            
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
                            .padding(.horizontal, 1)
                            
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
                            .padding(.horizontal, 1)
                        }
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                
                Button {
                    if isWriteMode {
                        viewModel.createTripCompanion()
                        dismiss()
                    } else {
                        if let postId = tripCompanion?.id {
                            viewModel.updateTripCompanion(postId: postId)
                            showingCompleteUpdateAlert = true
                        }
                    }
                } label: {
                    Text("등록하기")
                }
                .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
                .disabled(!viewModel.isComplete)
                .padding()
                .background(
                    Color.white
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                        .mask(Rectangle().padding(.top, -20))
                )
                
            }
            
            if showingCompleteUpdateAlert {
                if showingCompleteUpdateAlert {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    CompleteUpdateAlertView(showingAlert: $showingCompleteUpdateAlert)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !viewModel.hasAppeared {
                if let tripCompanion = tripCompanion {
                    viewModel.region = tripCompanion.region
                    viewModel.startDate = tripCompanion.tripDate.toDate()
                    viewModel.personal = String(tripCompanion.companionMemberCount)
                    viewModel.title = tripCompanion.title
                    viewModel.contents = tripCompanion.contents
                    viewModel.openKakaoUrl = tripCompanion.openKakaoUrl ?? ""
                    
                    for category in tripCompanion.categories {
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
            } else {
                
            }
            viewModel.hasAppeared = true
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

#Preview {
    WriteTripCompanionView(isWriteMode: false, viewModel: WriteTripCompanionViewModel.MOCK_VIEW_MODEL)
}
