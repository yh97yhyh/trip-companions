//
//  MyPostsViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/28/24.
//

import Foundation

class MyPostsViewModel: ObservableObject {
    @Published var myPosts: [TripCompanion] = []
    
    init(myPosts: [TripCompanion] = []) {
        self.myPosts = myPosts
    }
}

extension MyPostsViewModel {
    static let MOCK_VIEW_MODEL = MyPostsViewModel(myPosts: TripCompanion.MOCK_TRIP_COMPANIONS)
}
