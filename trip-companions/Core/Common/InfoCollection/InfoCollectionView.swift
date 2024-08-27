//
//  InfoCollectionView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct InfoCollectionView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var genderAndMbtiViewModel: GenderAndMbtiViewModel
    @StateObject private var viewModel = InfoCollectionViewModel.shared
    var isEditMode: Bool
    @Environment(\.dismiss) private var dismiss
    
//    init(isEditMode: Bool) {
//        self.isEditMode = isEditMode
//        if isEditMode {
//            viewModel.nickname = myPageViewModel.member.nickName ?? ""
//            viewModel.mbti = myPageViewModel.member.mbti ?? MBTI.MOCK_MBTIS[0]
//            viewModel.isSmoking = myPageViewModel.member.isSmoking ?? nil
//            viewModel.isDrinking = myPageViewModel.member.isDrinking ?? nil
//        }
//    }
        
    var body: some View {
        VStack {
            if isEditMode {
                NavigationTitleView(title: "프로필 관리")
                    .padding(.horizontal)
            }
            ScrollView(showsIndicators: false) {
                if !isEditMode {
                    HStack {
                        Text("프로필")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom, 32)
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("닉네임")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalEssentialTextModifier())
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
                                .modifier(AdditionalEssentialTextModifier())
                        }
                        
                        TextField("나이 입력", text: $viewModel.age)
                            .textFieldStyle(CustomTextFieldStyle(isEditing: viewModel.isEditingAge))
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                viewModel.isEditingAge = true
                                viewModel.isEditingNickname = false
                            }
                            .disabled(true)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("성별")
                                .modifier(Title2TextModifier())
                            Text ("(필수)")
                                .modifier(AdditionalEssentialTextModifier())
                        }
                        
                        // MARK: - Update to use Cusotm PickerView
                        Picker("성별", selection: $viewModel.gender) {
                            ForEach(genderAndMbtiViewModel.genders, id: \.code) { gender in
                                Text(gender.desc)
                                    .tag(gender as Gender)
                            }
                        }
                        .accentColor(.black)
                        .labelsHidden()
                        .frame(alignment: .leading)
                        .modifier(CustomPickerStyle())
                        .disabled(true)
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("MBTI")
                                .modifier(Title2TextModifier())
                            Text("(선택)")
                                .modifier(AdditionalOptionalTextModifier())
                        }
                        
                        // MARK: - Update to use Cusotm PickerView
                        Picker("MBTI", selection: $viewModel.mbti) {
                            ForEach(genderAndMbtiViewModel.mbtis, id: \.code) { mbti in
                                Text(mbti.desc)
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
                                .modifier(AdditionalOptionalTextModifier())
                        }
                        
                        HStack {
                            Button {
                                viewModel.isSmoking = viewModel.isSmoking == true ? nil : true
                            } label: {
                                Text("Yes")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isSmoking == true))
                            
                            Button {
                                viewModel.isSmoking = viewModel.isSmoking == false ? nil : false
                            } label: {
                                Text("No")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isSmoking == false))
                            
                        }
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("음주 여부")
                                .modifier(Title2TextModifier())
                            Text("(선택)")
                                .modifier(AdditionalOptionalTextModifier())
                        }
                        
                        HStack {
                            Button {
                                viewModel.isDrinking = viewModel.isDrinking == true ? nil : true
                            } label: {
                                Text("Yes")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isDrinking == true))
                            
                            Button {
                                viewModel.isDrinking = viewModel.isDrinking == false ? nil : false
                            } label: {
                                Text("No")
                            }
                            .buttonStyle(WidthMaxSelectButtonStyle(isSelected: viewModel.isDrinking == false))
                        }
                    }
                    .padding(.bottom)
                }
                //            .padding(.top)
            }
            .padding()
            
            Button {
                viewModel.updateMemberProfile { member in
                    authManager.currentMember = member
                    myPageViewModel.member = member
                    dismiss()
                }
            } label: {
                Text("완료")
            }
            .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
            .disabled(!viewModel.isComplete)
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if isEditMode {
                viewModel.nickname = myPageViewModel.member.nickName ?? ""
                viewModel.mbti = myPageViewModel.member.mbti ?? MBTI.MOCK_MBTIS[0]
                viewModel.isSmoking = myPageViewModel.member.isSmoking ?? nil
                viewModel.isDrinking = myPageViewModel.member.isDrinking ?? nil
            }
        }
    }
}

#Preview {
    InfoCollectionView(isEditMode: false)
        .environmentObject(AuthManager.shared)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
        .environmentObject(GenderAndMbtiViewModel())
}