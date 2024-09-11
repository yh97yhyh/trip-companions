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
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = viewModel.tripCompanion.member.profileImageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.trailing, 12)
                    .padding(.bottom)
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
                .padding(.bottom)
            }
            
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
            
            Text(viewModel.tripCompanion.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.bottom, 2)
            
            Text(viewModel.tripCompanion.region.regionName)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(.gray767676)
                .padding(.bottom, 4)
            
            Text(viewModel.tripCompanion.tripDate.toDateText())
                .font(.subheadline)
                .foregroundColor(.gray767676)
        }
    }
}


#Preview {
    HomeTripCompanionCellView(viewModel: HomeTripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
