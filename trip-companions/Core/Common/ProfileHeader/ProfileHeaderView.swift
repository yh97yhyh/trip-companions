//
//  ProfileHeaderView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct ProfileHeaderView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: ProfileHeaderViewModel
    @State var selectedImage: UIImage?
    @State var showingImagePicker = false
    @State var showingActionSheet = false
    
    var isHomeView = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    if myPageViewModel.member.profileImageUrl == nil {
                        showingImagePicker = true
                    } else {
                        showingActionSheet = true
                    }
                } label: {
                    ZStack(alignment: .bottomTrailing) {
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
                        Image("icn_profile_image")
                            .offset(x: -8, y: 8)
                    }
                }
                .disabled(AuthManager.shared.isGuestMode)
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(selectedImage: $myPageViewModel.image) {
                        myPageViewModel.updateProfileImage()
                    }
                }
                .confirmationDialog("프로필 이미지 변경", isPresented: $showingActionSheet, titleVisibility: .visible) {
                    Button("앨범에서 선택") {
                        showingImagePicker = true
                    }
                    Button("프로필사진 삭제", role: .destructive) {
                        myPageViewModel.image = nil
                        myPageViewModel.updateProfileImage()
                    }
                    Button("닫기", role: .cancel) {
                        
                    }
                }
                
                if AuthManager.shared.isGuestMode {
                    Text("로그인이 필요합니다")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 8)
                } else {
                    if viewModel.isHomeView {
                        VStack(alignment: .leading) {
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
                            .padding(.bottom, 8)
                            
                            Text("\(myPageViewModel.member.nickName!), \(myPageViewModel.member.age)")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    } else {
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
                    }
                }
                
                
                Spacer()
                
                if viewModel.isHomeView {
                    NavigationLink(destination: InfoCollectionView(isEditMode: true)) {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    .disabled(AuthManager.shared.isGuestMode)
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var onImagePicked: (() -> Void)?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let uiImage = info[.editedImage] as? UIImage {
                parent.selectedImage = uiImage
                parent.onImagePicked?()
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


#Preview {
    ProfileHeaderView(viewModel: ProfileHeaderViewModel.MOCK_VIEW_MODEL1)
        .environmentObject(MyPageViewModel.MOCK_VIEW_MODEL)
}
