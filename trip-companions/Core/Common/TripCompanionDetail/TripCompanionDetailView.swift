//
//  TripCompanionDetailView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct TripCompanionDetailView: View {
    @StateObject var viewModel: TripCompanionDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ProfileHeaderView(viewModel: ProfileHeaderViewModel(member: viewModel.tripCompanion.member, isShowingProfileUpdateButton: false))
                    .padding(.bottom)
                
                Divider()
                    .padding(.bottom)

                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.tripCompanion.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        Text(viewModel.tripCompanion.contents)
                            .font(.subheadline)
                            .foregroundColor(.gray767676)
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("여행 계획이에요")
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // MARK: - Add options
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("이런 분이면 좋겠어요")
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // MARK: - Add options
                }
                .padding(.bottom)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("목록")
                    }
                    .buttonStyle(CompleButtonStyle2(isComplete: true))
                    
                    Button {
                        
                    } label: {
                        Text("오픈 채팅 바로가기")
                    }
                    .buttonStyle(CompleButtonStyle(isComplete: true))
                }
                
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TripCompanionDetailView(viewModel: TripCompanionDetailViewModel.MOCK_VIEW_MODEL)
}
