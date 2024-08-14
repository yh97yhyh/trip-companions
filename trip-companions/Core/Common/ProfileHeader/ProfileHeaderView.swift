//
//  ProfileHeaderView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @StateObject var viewModel: ProfileHeaderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                if viewModel.member.profileImageUrl != nil {
                    // MARK: - Update to KFImage
                    Image("ProfileImageTest")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
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
                    Text("\(viewModel.member.nickName), \(viewModel.member.age)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 12)
                    
                    HStack {
                        Text(viewModel.toTextIsSmoking())
                            .modifier(FeatureTextModifier())
                        
                        Text(viewModel.toTextIsDrinking())
                            .modifier(FeatureTextModifier())
                        
                        Text(viewModel.member.mbti.rawValue)
                            .modifier(FeatureTextModifier())
                        
                        Text(viewModel.member.gender.rawValue)
                            .modifier(FeatureTextModifier())
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
}
