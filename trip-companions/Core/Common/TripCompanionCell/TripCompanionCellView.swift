//
//  TripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import SwiftUI
import Kingfisher

struct TripCompanionCellView: View {
    @StateObject var viewModel: TripCompanionCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    if let imageUrl = viewModel.tripCompanion.member.profileImageUrl {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .cornerRadius(10)
                            .padding(.trailing, 12)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.grayA2A2A2.opacity(0.1))
                                .frame(width: 70, height: 70)
                            Image("defaultThumbnail")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                        }
                        .padding(.trailing, 12)
                    }
                    
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        if viewModel.tripCompanion.member.mbti != nil {
                            Text(viewModel.tripCompanion.member.mbti!.desc)
                                .font(.footnote)
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if let gender = viewModel.tripCompanion.member.gender {
                            Text(gender.desc)
                                .font(.footnote)
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if let isDrinking = viewModel.tripCompanion.member.isDrinking {
                            if isDrinking {
                                Text("음주")
                                    .font(.footnote)
                                    .modifier(ProfileFeatureTextModifier())
                            } else {
                                Text("논알콜")
                                    .font(.footnote)
                                    .modifier(ProfileFeatureTextModifier())
                            }
                        }
                        
                        if let isSmoking = viewModel.tripCompanion.member.isSmoking {
                            if isSmoking {
                                Text("흡연")
                                    .font(.footnote)
                                    .modifier(ProfileFeatureTextModifier())
                            } else {
                                Text("비흡연")
                                    .font(.footnote)
                                    .modifier(ProfileFeatureTextModifier())
                            }
                        }
                    }
                    
                    HStack {
                        Text(viewModel.tripCompanion.title)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                    }

                    HStack {
                        Text(viewModel.tripCompanion.region.regionName)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(.gray767676)
                        Spacer()
                    }
                    
                    HStack {
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.tripCompanion.tripDate.toCellDateFormat())
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                        
                        Spacer()
                        
                        InterestHeartView(viewModel: InterestHeartViewModel(tripCompanion: viewModel.tripCompanion),isDetail: false, isInterest: viewModel.tripCompanion.interestTripCompanion ?? false, inerestCount: viewModel.tripCompanion.interestTripCompanionCount)
                    }
                    
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    TripCompanionCellView(viewModel: TripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
