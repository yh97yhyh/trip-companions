//
//  ImagePicker.swift
//  trip-companions
//
//  Created by 영현 on 9/25/24.
//

//import Foundation
//import SwiftUI
//import PhotosUI
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            // 선택된 이미지를 초기화
//            parent.selectedImage = nil
//
//            if let firstResult = results.first {
//                let itemProvider = firstResult.itemProvider
//
//                if itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    itemProvider.loadObject(ofClass: UIImage.self) { image, error in
//                        DispatchQueue.main.async {
//                            if let image = image as? UIImage {
//                                self.parent.selectedImage = image
//                            }
//                        }
//                    }
//                }
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    @Environment(\.presentationMode) var presentationMode
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        config.selectionLimit = 1  // 1로 변경하여 한 번에 하나의 이미지 선택
//
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
//}
