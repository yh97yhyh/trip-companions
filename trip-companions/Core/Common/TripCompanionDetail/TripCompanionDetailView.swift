//
//  TripCompanionDetailView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct TripCompanionDetailView: View {
    @StateObject var viewModel: TripCompanionDetailViewModel
    @StateObject var interestHeartViewModel: InterestHeartViewModel
    @Environment(\.dismiss) private var dismiss
    @State var showingNoSignInAlert = false
    @State var showingBottomSheet = false
    @State var showingReportAlert = false
    @State var showingBlockAlert = false
    @State private var offset: CGSize = .zero

    var body: some View {
        ZStack {
            VStack {
                NavigationTitleView(title: "국내동행")
                    .padding(.horizontal)
                    .padding(.bottom)
                
                WriterHeaderView(viewModel: viewModel)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                DividerView()
                    .ignoresSafeArea()
                    .padding(.bottom)
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.tripCompanion.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if AuthManager.shared.isLoggedIn && AuthManager.shared.currentMember!.id != viewModel.tripCompanion.member.id {
                                Button {
                                    showingBottomSheet = true
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.black)
                                }
                                .sheet(isPresented: $showingBottomSheet) {
                                    ReportBottomView(showingBottomSheet: $showingBottomSheet, showingReportAlert: $showingReportAlert)
                                        .presentationDetents([.fraction(0.4), .height(110), .medium, .large])
                                }
                            }
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Text(viewModel.tripCompanion.contents)
                                .font(.subheadline)
                                .foregroundColor(.gray767676)
                        }
                    }
                    .padding(.bottom, 32)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("여행 계획이에요")
                                .font(.title3)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Text(viewModel.tripCompanion.region.regionName)
                                .font(.subheadline)
                                .modifier(FeatureTextModifier())
                            
                            HStack {
                                Text(viewModel.tripCompanion.tripDate.toDetailDateFormat())
                            }
                            .font(.subheadline)
                            .modifier(FeatureTextModifier())
                            
                            Text("\(viewModel.tripCompanion.companionMemberCount)명")
                                .font(.subheadline)
                                .modifier(FeatureTextModifier2())
                        }
                        .padding(.horizontal, 1)
                    }
                    .padding(.bottom, 32)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("이런 분이면 좋겠어요")
                                .font(.title3)

                            Spacer()
                        }
                        .padding(.bottom, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.tripCompanion.categories, id: \.self) { category in
                                    Text(category.categoriesType)
                                        .font(.subheadline)
                                        .modifier(FeatureTextModifier2())
                                }
                            }
                            .padding(1)
                        }
                    }
                    .padding(.bottom, 32)
                    
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    InterestHeartView(viewModel: interestHeartViewModel, viewType: .detail)
                        .padding(.trailing, 24)
                    Spacer()
                    Button {
                        if AuthManager.shared.isGuestMode {
                            showingNoSignInAlert = true
                            return
                        }
                        if let url = URL(string: viewModel.tripCompanion.openKakaoUrl ?? "") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("오픈 채팅 바로가기")
                    }
                    .buttonStyle(CompleButtonStyle(isComplete: true))
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(
                    Color.white
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 0)
                        .mask(Rectangle().padding(.top, -20))
                )
            }
            
            if showingNoSignInAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                NoSignInAlertView(showingAlert: $showingNoSignInAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
            
            if showingReportAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                ReportAlertView(viewModel: viewModel, showingAlert: $showingReportAlert, showingBlockAlert: $showingBlockAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
            
            if showingBlockAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                UserBlockAlertView(viewModel: viewModel, showingAlert: $showingBlockAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
//        .offset(x: offset.width)
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    // 사용자가 스와이프 하는 동안 뷰의 오프셋을 업데이트
//                    offset.width = value.translation.width
//                }
//                .onEnded { value in
//                    if value.translation.width > 100 { // 오른쪽으로 스와이프
//                        withAnimation {
//                            offset.width = UIScreen.main.bounds.width // 전체 화면만큼 이동
//                        }
//                        dismiss() // 뷰를 종료
//                    } else {
//                        withAnimation {
//                            offset = .zero // 원래 위치로 되돌리기
//                        }
//                    }
//                }
//        )
    }
}

struct WriterHeaderView: View  {
    @StateObject var viewModel: TripCompanionDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let imageUrl = viewModel.tripCompanion.member.profileImageUrl {
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
                    if let age = viewModel.tripCompanion.member.age {
                        Text("\(viewModel.tripCompanion.member.nickName!), \(age)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                    } else {
                        Text("\(viewModel.tripCompanion.member.nickName!)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                    }
                    
                    HStack {
                        if viewModel.tripCompanion.member.isSmoking != nil {
                            Text(viewModel.toTextIsSmoking(viewModel.tripCompanion.member.isSmoking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if viewModel.tripCompanion.member.isDrinking != nil {
                            Text(viewModel.toTextIsDrinking(viewModel.tripCompanion.member.isDrinking!))
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        
                        if viewModel.tripCompanion.member.mbti != nil {
                            Text(viewModel.tripCompanion.member.mbti!.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                        
                        if let gender = viewModel.tripCompanion.member.gender {
                            Text(gender.desc)
                                .modifier(ProfileFeatureTextModifier())
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ReportBottomView: View {
    @Binding var showingBottomSheet: Bool
    @Binding var showingReportAlert: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                showingReportAlert = true
                showingBottomSheet = false
            } label: {
                Text("신고하기")
                    .foregroundColor(.black)
            }
            .padding(.top)
            .padding(.bottom, 8)
            Divider()
                .padding(.bottom, 8)
            Button {
                showingBottomSheet = false
            } label: {
                Text("닫기")
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
}

#Preview {
    TripCompanionDetailView(viewModel: TripCompanionDetailViewModel.MOCK_VIEW_MODEL, interestHeartViewModel: InterestHeartViewModel.MOCK_VIEW_MODEL)
}
