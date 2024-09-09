//
//  MyTripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI

struct MyTripCompanionCellView: View {
    @StateObject var viewModel: MyTripCompanionCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
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

                    if viewModel.tripCompanion.startDate == viewModel.tripCompanion.endDate {
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.tripCompanion.startDate.toDateText())
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                    } else {
                        HStack {
                            Image(systemName: "calendar")
                            Text("\(viewModel.tripCompanion.startDate.toDateText()) ~ \(viewModel.tripCompanion.endDate.toDateText())")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                    }
                    
                }
                
                Spacer()
                
                // MARK: - Update to KFImage
                VStack {
                    Image("TripCompanionThumbnailTest")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                        .padding(.trailing, 12)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MyTripCompanionCellView(viewModel: MyTripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
