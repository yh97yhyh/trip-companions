//
//  TripCompanionDetailView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct TripCompanionDetailView: View {
    @StateObject var viewModel: TripCompanionDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                WriterHeaderView(viewModel: viewModel)
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
                .padding(.bottom, 32)

                VStack(alignment: .leading) {
                    HStack {
                        Text("여행 계획이에요")
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // MARK: - Add info
                    HStack {
                        Text(viewModel.tripCompanion.region.regionName)
                            .font(.subheadline)
                            .modifier(FeatureTextModifier())
                        
                        if viewModel.tripCompanion.startDate == viewModel.tripCompanion.endDate {
                            HStack {
                                Text(viewModel.tripCompanion.startDate.toDateText())
                            }
                            .font(.subheadline)
                            .modifier(FeatureTextModifier())
                        } else {
                            HStack {
                                Text("\(viewModel.tripCompanion.startDate.toDateText()) ~ \(viewModel.tripCompanion.endDate.toDateText())")
                            }
                            .font(.subheadline)
                            .modifier(FeatureTextModifier())
                        }
                        
                        Text("\(viewModel.tripCompanion.companionMemberCount)명")
                            .font(.subheadline)
                            .modifier(FeatureTextModifier2())
                    }
                }
                .padding(.bottom, 32)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("이런 분이면 좋겠어요")
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // MARK: - Add info
                }
                .padding(.bottom, 32)

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

struct WriterHeaderView: View  {
    @StateObject var viewModel: TripCompanionDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if viewModel.tripCompanion.member.profileImageUrl != nil {
                    KFImage(URL(string: viewModel.tripCompanion.member.profileImageUrl!))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                } else {
                    Image("ProfileImageTest")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                }
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.tripCompanion.member.nickName!), \(viewModel.tripCompanion.member.age)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 8)
                    
                    HStack {
                        if viewModel.tripCompanion.member.isSmoking != nil {
                            Text(viewModel.toTextIsSmoking(viewModel.tripCompanion.member.isSmoking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if viewModel.tripCompanion.member.isDrinking != nil {
                            Text(viewModel.toTextIsDrinking(viewModel.tripCompanion.member.isDrinking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        
                        if viewModel.tripCompanion.member.mbti != nil {
                            Text(viewModel.tripCompanion.member.mbti!.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if let gender = viewModel.tripCompanion.member.gender {
                            Text(gender.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    TripCompanionDetailView(viewModel: TripCompanionDetailViewModel.MOCK_VIEW_MODEL)
//}
