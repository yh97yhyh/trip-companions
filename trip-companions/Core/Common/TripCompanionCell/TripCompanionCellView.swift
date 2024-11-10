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
    @StateObject var interestHeartViewModel: InterestHeartViewModel
    
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
                        Image("default_profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .cornerRadius(10)
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
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Spacer()
                    }

                    HStack {
                        Image("icn_location")
                            .padding(.trailing, -6)
                        Text(viewModel.tripCompanion.region.regionName)
                            .font(.subheadline)
                            .foregroundColor(.gray767676)
                        Spacer()
                    }
                    .padding(.bottom, -2)
                    
                    HStack {
                        HStack {
                            Image("icn_calendar")
                                .padding(.trailing, -6)
                            Text(viewModel.tripCompanion.tripDate.toCellDateFormat())
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                        
                        Spacer()
                        
                        InterestHeartView(viewModel: interestHeartViewModel, viewType: .cell)
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    TripCompanionCellView(viewModel: TripCompanionCellViewModel.MOCK_VIEW_MODEL, interestHeartViewModel: InterestHeartViewModel.MOCK_VIEW_MODEL)
}
