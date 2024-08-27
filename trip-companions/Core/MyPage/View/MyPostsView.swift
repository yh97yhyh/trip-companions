//
//  MyPostsView.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import SwiftUI

struct MyPostsView: View {
    var body: some View {
        VStack {
            NavigationTitleView(title: "내 게시글 관리")
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyPostsView()
}
