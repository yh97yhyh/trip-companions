//
//  MyInterestingTripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import SwiftUI
import Kingfisher

struct MyInterestingTripCompanionCellView: View {
    @StateObject var viewModel: MyInterestingTripCompanionCellViewModel
    
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
                
                Spacer()
                
                VStack(alignment: .leading) {
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
                    
                    HStack {
                        Text(viewModel.tripCompanion.title)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
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
                        Image("icn_calendar")
                            .padding(.trailing, -6)
                        Text(viewModel.tripCompanion.tripDate.toCellDateFormat())
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray767676)
                }
                
                VStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.deleteLike()
                        }
                }
            }
        }
    }
}

#Preview {
    MyInterestingTripCompanionCellView(viewModel: MyInterestingTripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
