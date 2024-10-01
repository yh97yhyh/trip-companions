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
    @EnvironmentObject var metaDataViewModel: MetaDataViewModel
    @StateObject private var viewModel = InfoCollectionViewModel.shared
    var isEditMode: Bool
    @Environment(\.dismiss) private var dismiss
    @State var mockRegion: Region?
    @State var showingNoMbtiAlert = false
    @State private var shouldNavigate = false
        
    var body: some View {
        ZStack {
            VStack {
                if isEditMode {
                    NavigationTitleView(title: "프로필 관리")
                        .padding(.horizontal)
                }
                ScrollView(showsIndicators: false) {
                    VStack {
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
                                        .modifier(Title3TextModifier())
                                    Text ("(필수)")
                                        .modifier(AdditionalEssentialTextModifier())
                                }
                                
                                TextField("이름 입력", text: $viewModel.nickname)
                                    .textFieldStyle(CustomTextFieldStyle(isEditing: viewModel.isEditingNickname))
                                    .onTapGesture {
                                        viewModel.isEditingNickname = true
                                        viewModel.isEditingAge = false
                                    }
                                    .padding(.horizontal, 1)
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Text("나이")
                                        .modifier(Title3TextModifier())
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
                                //                                .disabled(true)
                                    .padding(.horizontal, 1)
                                
                            }
                            .padding(.bottom)
                            
//                            VStack(alignment: .leading) {
//                                HStack(spacing: 4) {
//                                    Text("성별")
//                                        .modifier(Title2TextModifier())
//                                    Text ("(필수)")
//                                        .modifier(AdditionalEssentialTextModifier())
//                                }
//                                
//                                Picker("성별", selection: $viewModel.gender) {
//                                    ForEach(metaDataViewModel.genders, id: \.code) { gender in
//                                        Text(gender.desc)
//                                            .tag(gender as Gender)
//                                    }
//                                }
//                                .accentColor(.black)
//                                .labelsHidden()
//                                .frame(alignment: .leading)
//                                .modifier(CustomPickerStyle())
//                                //                        .disabled(true)
//                            }
//                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Text("성별")
                                        .modifier(Title3TextModifier())
                                    Text("필수")
                                        .modifier(AdditionalEssentialTextModifier())
                                }
                                
                                Menu {
                                    ForEach(metaDataViewModel.genders, id: \.self) { gender in
                                        Button {
                                            viewModel.gender = gender
                                        } label: {
                                            VStack {
                                                Text(gender.desc)
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        if viewModel.gender == nil {
                                            Text("성별")
                                                .foregroundColor(.grayA2A2A2)
                                        } else {
                                            Text(viewModel.gender!.desc)
                                                .foregroundColor(.black)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.grayA2A2A2)
                                    }
                                }
                                .buttonStyle(SearchButtonStyle())
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Text("MBTI")
                                        .modifier(Title3TextModifier())
                                    Text("(선택)")
                                        .modifier(AdditionalOptionalTextModifier())
                                }
                                
                                Menu {
                                    ForEach(metaDataViewModel.mbtis, id: \.self) { mbti in
                                        Button {
                                            viewModel.mbti = mbti
                                        } label: {
                                            VStack {
                                                Text(mbti.desc)
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        if viewModel.mbti == nil {
                                            Text("MBTI")
                                                .foregroundColor(.grayA2A2A2)
                                        } else {
                                            Text(viewModel.mbti!.desc)
                                                .foregroundColor(.black)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.grayA2A2A2)
                                    }
                                }
                                .buttonStyle(SearchButtonStyle())
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Text("흡연 여부")
                                        .modifier(Title3TextModifier())
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
                                .padding(.horizontal, 1)
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 4) {
                                    Text("음주 여부")
                                        .modifier(Title3TextModifier())
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
                                .padding(.horizontal, 1)
                            }
                            .padding(.bottom)
                        }
                    }
                    //            .padding(.top)
                }
                .padding(.horizontal)
                
                VStack {
                    if isEditMode {
                        Button {
                            viewModel.updateMemberProfile { member in
                                authManager.currentMember = member
                                myPageViewModel.member = member
                            }
                            dismiss()
                        } label: {
                            Text("완료")
                        }
                        .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
                        .disabled(!viewModel.isComplete)
                        .padding(.horizontal)
                    } else {
                        if viewModel.mbti == nil {
                            Button {
                                showingNoMbtiAlert = true
                            } label: {
                                Text("완료")
                            }
                            .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
                            .disabled(!viewModel.isComplete)
                            .padding(.horizontal)
                            .background(
                                NavigationLink(destination: SelectRegionView(viewModel: SelectRegionViewModel(), bindedRegion: $mockRegion)
                                    .environmentObject(myPageViewModel), isActive: $shouldNavigate) {
                                        EmptyView()
                                    }
                            )
                        } else {
                            NavigationLink(destination: SelectRegionView(viewModel: SelectRegionViewModel(), bindedRegion: $mockRegion)
                                .environmentObject(myPageViewModel)) {
                                    Text("완료")
                                }
                                .buttonStyle(CompleButtonStyle(isComplete: viewModel.isComplete))
                                .disabled(!viewModel.isComplete)
                                .padding(.horizontal)
                                .onTapGesture {
                                    print("완료! 다음페이지")
                                    viewModel.updateMemberProfile { member in
                                        authManager.currentMember = member
                                        myPageViewModel.member = member
                                    }
                                }
                        }
                        
                    }
                }
                .padding(.vertical)
                .background(
                    Color.white
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                        .mask(Rectangle().padding(.top, -20))
                )
            }
            
            if showingNoMbtiAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                NoMbtiAlertView(showingAlert: $showingNoMbtiAlert, shouldNavigate: $shouldNavigate)
                    .environmentObject(authManager)
                    .environmentObject(myPageViewModel)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if isEditMode {
                viewModel.nickname = myPageViewModel.member.nickName ?? ""
                viewModel.mbti = myPageViewModel.member.mbti ?? nil
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
        .environmentObject(MetaDataViewModel())
}
