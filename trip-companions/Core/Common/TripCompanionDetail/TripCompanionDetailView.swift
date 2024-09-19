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
            NavigationTitleView(title: "국내동행")
                .padding(.horizontal)
                .padding(.bottom)
            
            WriterHeaderView(viewModel: viewModel)
                .padding(.horizontal)
                .padding(.bottom)
            
            DividerView()
                .ignoresSafeArea()
                .padding(.bottom)
            
            ScrollView(showsIndicators: false) {

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
                    
                    HStack {
                        Text(viewModel.tripCompanion.region.regionName)
                            .font(.subheadline)
                            .modifier(FeatureTextModifier())

                        HStack {
                            Text(viewModel.tripCompanion.tripDate.toDetailDateFormat())
                        }
                        .font(.subheadline)
                        .modifier(FeatureTextModifier())
                        
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
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.tripCompanion.categories, id: \.self) { category in
                                Text(category.categoriesType)
                                    .font(.subheadline)
                                    .modifier(FeatureTextModifier2())
                            }
                        }
                    }
                }
                .padding(.bottom, 32)

//                HStack {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Text("목록")
//                    }
//                    .buttonStyle(CompleButtonStyle2(isComplete: true))
//                    
//                    Button {
//                        
//                    } label: {
//                        Text("오픈 채팅 바로가기")
//                    }
//                    .buttonStyle(CompleButtonStyle(isComplete: true))
//                }
                
            }
            .padding(.horizontal)
            
            HStack {
                InterestHeartView(isDetail: true, isInterest: viewModel.tripCompanion.interestTripCompanion ?? false, inerestCount: viewModel.tripCompanion.interestTripCompanionCount)
                    .padding(.trailing, 24)
                
                Spacer()
                
                Button {
                } label: {
                    Text("오픈 채팅 바로가기")
                }
                .buttonStyle(CompleButtonStyle(isComplete: true))
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct WriterHeaderView: View  {
    @StateObject var viewModel: TripCompanionDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let imageUrl = viewModel.tripCompanion.member.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                } else {
                    ZStack {
                        Circle()
                            .fill(.grayA2A2A2.opacity(0.1))
                            .frame(width: 64, height: 64)
                        Image("defaultThumbnail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
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

#Preview {
    TripCompanionDetailView(viewModel: TripCompanionDetailViewModel.MOCK_VIEW_MODEL)
}
