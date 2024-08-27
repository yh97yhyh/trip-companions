//
//  ProfileHeaderView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: ProfileHeaderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                if viewModel.member.profileImageUrl != nil {
                    // MARK: - Update to KFImage
                if myPageViewModel.member.profileImageUrl != nil {
                    KFImage(URL(string: myPageViewModel.member.profileImageUrl!))
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
//                } else {
//                    Image("defaultThumbnail")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 60, height: 60)
//                        .padding(4)
//                        .background(Color.grayF1F1F1)
//                        .clipShape(Circle())
//                        .padding(.trailing, 12)
//                }
                
                VStack(alignment: .leading) {
                    Text("\(myPageViewModel.member.nickName!), \(myPageViewModel.member.age)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 8)
                    
                    HStack {
                        if myPageViewModel.member.isSmoking != nil {
                            Text(viewModel.toTextIsSmoking(myPageViewModel.member.isSmoking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if myPageViewModel.member.isDrinking != nil {
                            Text(viewModel.toTextIsDrinking(myPageViewModel.member.isDrinking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        
                        if myPageViewModel.member.mbti != nil {
                            Text(myPageViewModel.member.mbti!.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        Text(myPageViewModel.member.gender.desc)
                            .modifier(ProfileFeatureTextModifier())
                    }
                }
                
                Spacer()
                
                if viewModel.isShowingProfileUpdateButton {
                    // MARK: - Update to NavigationLink
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileHeaderView(viewModel: ProfileHeaderViewModel.MOCK_VIEW_MODEL1)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
