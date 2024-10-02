//
//  PostDeleteAlertView.swift
//  trip-companions
//
//  Created by 영현 on 10/2/24.
//

import SwiftUI

struct PostDeleteAlertView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showingAlert: Bool
    
    var postId: Int

    var body: some View {
        VStack {
            HStack {
                Text("내 게시글들을 삭제하시겠습니까?")
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text("(삭제하면 다시 되돌릴 수 없습니다.)")
                    .foregroundColor(.gray767676)
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Button {
                    showingAlert = false
                } label: {
                    HStack {
                        Text("아니요")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                Button {
                    MyPostsViewModel.shared.deletePost(postId: postId)
                    showingAlert = false
                } label: {
                    Text("네")
                        .foregroundColor(.orangeF49321)
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

//#Preview {
//    PostDeleteAlertView()
//}
