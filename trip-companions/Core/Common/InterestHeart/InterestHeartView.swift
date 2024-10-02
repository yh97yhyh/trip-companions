//
//  InterestHeartView.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import SwiftUI

struct InterestHeartView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var viewModel: InterestHeartViewModel
    var viewType: InterestHeartViewType
    
    var body: some View {
        VStack {
            switch viewType {
            case .detail:
                VStack {
                    if viewModel.isUpdateHeartLike {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: false)
                            }
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray767676)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: true)
                            }
                    }
                    Text("\(viewModel.updateHeartCount)")
                        .foregroundColor(.gray767676)
                        .font(.subheadline)
                }
            case .cell:
                HStack {
                    if viewModel.isUpdateHeartLike {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: false)
                            }
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray767676)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: true)
                            }
                    }
                    Text("\(viewModel.updateHeartCount)")
                        .foregroundColor(.gray767676)
                        .font(.subheadline)
                }
            case .mypage:
                VStack {
                    if viewModel.isUpdateHeartLike {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: false)
                            }
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray767676)
                            .onTapGesture {
                                if authManager.isGuestMode {
                                    return
                                }
                                viewModel.toggleLike(writer: authManager.currentMember!, isLike: true)
                            }
                    }
                }
            }
            
        }
    }
}

enum InterestHeartViewType {
    case detail
    case cell
    case mypage
}

#Preview {
    InterestHeartView(viewModel: InterestHeartViewModel.MOCK_VIEW_MODEL, viewType: .detail)
        .environmentObject(AuthManager.shared)
}
