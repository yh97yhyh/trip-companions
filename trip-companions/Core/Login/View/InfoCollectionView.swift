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
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("닉네임")
                        .modifier(Title3Modifier())
                    
                    TextField("이름 입력", text: $viewModel.nickname)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("나이")
                        .modifier(Title3Modifier())
                    
                    TextField("나이 입력", text: $viewModel.age)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("성별")
                        .modifier(Title3Modifier())
                    
                    Picker("성별", selection: $viewModel.gender) {
                        ForEach(Gender.allCases) { gender in
                            Text(gender.rawValue)
                                .tag(gender as Gender)
                        }
                    }
                    .accentColor(.black)
                    .modifier(CustomPickerStyle())
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("MBTI")
                        .modifier(Title3Modifier())
                    
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
                    Text("흡연 여부")
                        .modifier(Title3Modifier())
                    
                    HStack {
                        Button {
                            viewModel.isSmoker = true
                        } label: {
                            Text("Yes")
                        }
                        .buttonStyle(CustomButtonStyle(isSelected: viewModel.isSmoker == true))    .padding(.trailing, 6)
                        
                        Button {
                            viewModel.isSmoker = false
                        } label: {
                            Text("No")
                        }
                        .buttonStyle(CustomButtonStyle(isSelected: viewModel.isSmoker == false))
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("음주 여부")
                        .modifier(Title3Modifier())
                    
                    HStack {
                        Button {
                            viewModel.isDrinker = true
                        } label: {
                            Text("Yes")
                        }
                        .buttonStyle(CustomButtonStyle(isSelected: viewModel.isDrinker == true))         .padding(.trailing, 6)
                        
                        Button {
                            viewModel.isDrinker = false
                        } label: {
                            Text("No")
                        }
                        .buttonStyle(CustomButtonStyle(isSelected: viewModel.isDrinker == false))
                    }
                }
                .padding(.bottom)
                
                Button {
                    
                } label: {
                    Text("완료")
                }
                .buttonStyle(CustomButtonStyle2())
                .disabled(!viewModel.isFromValid)
                .opacity(viewModel.isFromValid ? 1.0 : 0.4)
                .padding(.top)
            }
            //            .padding(.top)
            .padding(.horizontal)
        }
    }
}

#Preview {
    InfoCollectionView()
}
