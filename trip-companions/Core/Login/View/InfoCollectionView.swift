//
//  InfoCollectionView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct InfoCollectionView: View {
    @StateObject private var viewModel = InfoCollectionViewModel.shared
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("닉네임")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalTextModifier())
                        }
                        
                        TextField("이름 입력", text: $viewModel.nickname)
                            .textFieldStyle(CustomTextFieldStyle(isEditing: viewModel.isEditingNickname))
                            .onTapGesture {
                                viewModel.isEditingNickname = true
                                viewModel.isEditingAge = false
                            }
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("나이")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalTextModifier())
                        }
                        
                        TextField("나이 입력", text: $viewModel.age)
                            .textFieldStyle(CustomTextFieldStyle(isEditing: viewModel.isEditingAge))
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                viewModel.isEditingAge = true
                                viewModel.isEditingNickname = false
                            }
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("성별")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalTextModifier())
                        }
                        
                        // MARK: - Update to use Cusotm PickerView
                        Picker("성별", selection: $viewModel.gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(gender.rawValue)
                                    .tag(gender as Gender)
                            }
                        }
                        .accentColor(.black)
                        .labelsHidden()
                        .frame(alignment: .leading)
                        .modifier(CustomPickerStyle())
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("MBTI")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalTextModifier())
                        }
                        
                        // MARK: - Update to use Cusotm PickerView
                        Picker("MBTI", selection: $viewModel.mbti) {
                            ForEach(MBTI.allCases) { mbti in
                                Text(mbti.rawValue)
                                    .tag(mbti as MBTI)
                            }
                        }
                        .accentColor(.black)
                        .modifier(CustomPickerStyle())
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("흡연 여부")
                                .modifier(Title2TextModifier())
                            Text("(선택)")
                                .modifier(AdditionalTextModifier2())
                        }
                        
                        HStack {
                            Button {
                                viewModel.isSmoker = viewModel.isSmoker == true ? nil : true
                            } label: {
                                Text("Yes")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isSmoker == true))
                            
                            Button {
                                viewModel.isSmoker = viewModel.isSmoker == false ? nil : false
                            } label: {
                                Text("No")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isSmoker == false))
                            
                        }
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("음주 여부")
                                .modifier(Title2TextModifier())
                            Text("(선택)")
                                .modifier(AdditionalTextModifier2())
                        }
                        
                        HStack {
                            Button {
                                viewModel.isDrinker = viewModel.isDrinker == true ? nil : true
                            } label: {
                                Text("Yes")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isDrinker == true))
                            
                            Button {
                                viewModel.isDrinker = viewModel.isDrinker == false ? nil : false
                            } label: {
                                Text("No")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isDrinker == false))
                        }
                    }
                    .padding(.bottom)
                }
                //            .padding(.top)
                .padding(.horizontal)
            }
            
            Button {
                
            } label: {
                Text("완료")
            }
            .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
            .disabled(!viewModel.isComplete)
            .padding(.top)
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InfoCollectionView()
}
