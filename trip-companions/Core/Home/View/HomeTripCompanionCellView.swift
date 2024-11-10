//
//  HomeTripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 9/12/24.
//

import SwiftUI
import Kingfisher

struct HomeTripCompanionCellView: View {
    @StateObject var viewModel: HomeTripCompanionCellViewModel
    @StateObject var interestHeartViewModel: InterestHeartViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let imageUrl = viewModel.tripCompanion.member.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                        .padding(.bottom)
                } else {
                    Image("default_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                        .padding(.bottom)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        HStack {
                            if let mbti = viewModel.tripCompanion.member.mbti {
                                Text(mbti.desc)
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
                    }
                    
                    Text("동행")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
            }
            
            Divider()
                .padding(.bottom)
            
            Text(viewModel.tripCompanion.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .truncationMode(.tail)
                .padding(.bottom, 4)
            
            HStack {
                Image("icn_location")
                    .padding(.trailing, -6)
                Text(viewModel.tripCompanion.region.regionName)
                    .font(.subheadline)
                    .foregroundColor(.gray767676)
                    .padding(.bottom, 2)
            }
            .padding(.bottom, -2)
            
            HStack {
                Image("icn_calendar")
                    .padding(.trailing, -6)
                Text(viewModel.tripCompanion.tripDate.toCellDateFormat())
                    .font(.subheadline)
                    .foregroundColor(.gray767676)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                InterestHeartView(viewModel: interestHeartViewModel, viewType: .cell)
                .padding(.trailing)
            }
        }
    
    }
}


#Preview {
    HomeTripCompanionCellView(viewModel: HomeTripCompanionCellViewModel.MOCK_VIEW_MODEL, interestHeartViewModel: InterestHeartViewModel.MOCK_VIEW_MODEL)
}
