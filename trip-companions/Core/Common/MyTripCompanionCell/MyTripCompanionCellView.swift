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
                        Text(viewModel.tripCompanion.region.regionName)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(.gray767676)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "calendar")
                        Text(viewModel.tripCompanion.tripDate.toCellDateFormat())
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray767676)
                    .padding(.bottom, 8)
                    
                    HStack {
                        Button {
                            
                        } label: {
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
//                        .alert("정말 삭제하시겠습니까?", isPresented: $showAlert) {
//                            Button("삭제", role: .destructive) {
//                                // 삭제 로직을 여기에 추가
//                            }
//                            Button("취소", role: .cancel) { }
//                        }
                        
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
