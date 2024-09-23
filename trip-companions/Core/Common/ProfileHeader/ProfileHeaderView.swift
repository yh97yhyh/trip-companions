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
                if let imageUrl = myPageViewModel.member.profileImageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                } else {
                    Image("default_profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                }
                
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
                        
                        if let gender = myPageViewModel.member.gender {
                            Text(gender.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                    }
                }
                
                Spacer()
                
                if viewModel.isShowingProfileUpdateButton {
                    NavigationLink(destination: InfoCollectionView(isEditMode: true)) {
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
