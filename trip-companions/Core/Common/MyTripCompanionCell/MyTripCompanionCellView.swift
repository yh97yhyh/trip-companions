//
//  MyTripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI
import Kingfisher

struct MyTripCompanionCellView: View {
    @StateObject var viewModel: MyTripCompanionCellViewModel
    @State private var showAlert = false
    
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
                    .padding(.bottom, 8)
                    
                    HStack {
                        NavigationLink(destination: WriteTripCompanionView(isWriteMode: false, tripCompanion: viewModel.tripCompanion, viewModel: WriteTripCompanionViewModel())) {
                            Text("수정")
                                .font(.subheadline)
                        }
                        .buttonStyle(MyPageButtonStyle())
                        
                        Button {
                            MyPostsViewModel.shared.deletePost(postId: viewModel.tripCompanion.id)
                        } label: {
                            Text("삭제")
                                .font(.subheadline)
                        }
                        .buttonStyle(MyPageButtonStyle())
                        
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    MyTripCompanionCellView(viewModel: MyTripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
