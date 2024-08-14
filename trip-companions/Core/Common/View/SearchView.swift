//
//  SearchView.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import SwiftUI

struct SearchView: View {
    @State var regionName: String = ""
    @State var date: Date = Date()
    @State var isMale: Bool? = nil
    @State var isDrinker: Bool? = nil
    @State var isSmoker: Bool? = nil
    @State var detail: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("여기는 어떠신가요?")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextField("지역명을 입력하세요", text: $regionName)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                }
                .padding(.bottom, 24)

                VStack {
                    HStack {
                        Text("날짜 입력")
                            .modifier(Title3Modifier())
                        
                        Spacer()
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("날짜를 입력하세요")
                            Spacer()
//                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .buttonStyle(SearchButtonStyle())
                    
                }
                .padding(.bottom, 24)

                VStack {
                    HStack {
                        Text("당신의 동행은?")
                            .modifier(Title3Modifier())
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            isMale = isMale == true ? nil : true
                        } label: {
                            Text("남성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isMale == true))
                        
                        Button {
                            isMale = isMale == false ? nil : false
                        } label: {
                            Text("여성")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isMale == false))
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            isDrinker = isDrinker == true ? nil : true
                        } label: {
                            Text("음주")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isDrinker == true))
                        
                        Button {
                            isDrinker = isDrinker == false ? nil : false
                        } label: {
                            Text("논알콜")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isDrinker == false))
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            isSmoker = isSmoker == true ? nil : true
                        } label: {
                            Text("흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSmoker == true))
                        
                        Button {
                            isSmoker = isSmoker == false ? nil : false
                        } label: {
                            Text("비흡연")
                        }
                        .buttonStyle(SelectButtonStyle(isSelected: isSmoker == false))
                        Spacer()
                    }
                }
                .padding(.bottom, 24)
                
                VStack {
                    HStack {
                        Text("세부 조건")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextField("조건 입력", text: $detail)
                        .textFieldStyle(CustomTextFieldStyle(isEditing: false))
                }
            }
            .padding(.top)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("검색 결과 보기")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
            .padding(.top)
            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView()
}
