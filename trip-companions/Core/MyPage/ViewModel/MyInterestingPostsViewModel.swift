//
//  MyInterestingPostsViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/19/24.
//

import Foundation

class MyInterestingPostsViewModel: ObservableObject {
    static let shared = MyInterestingPostsViewModel()
    
    @Published var myInterestingPosts: [TripCompanion] = []
    
    init(myInterestingPosts: [TripCompanion] = []) {
        self.myInterestingPosts = myInterestingPosts
    }

}

extension MyInterestingPostsViewModel {
    static let MOCK_VIEW_MODEL = MyInterestingPostsViewModel(myInterestingPosts: TripCompanion.MOCK_TRIP_COMPANIONS)

}
