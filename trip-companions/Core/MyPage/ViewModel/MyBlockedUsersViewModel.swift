//
//  MyBlockedUsersViewModel.swift
//  trip-companions
//
//  Created by 영현 on 1/15/25.
//

import Foundation
import Alamofire
import Combine

class MyBlockedUsersViewModel: ObservableObject {
    static let shared = MyBlockedUsersViewModel()
    
    @Published var blockedUsers: [BlockedUser] = []

    var cancellables = Set<AnyCancellable>()
    
    @Published var isFetching = false

    init(blockedUsers: [BlockedUser] = []) {
        self.blockedUsers = blockedUsers
        
    }

    func fetchBlcokedUsers() {
        if isFetching { return }
        blockedUsers.removeAll()
        
        isFetching = true
        
        NetworkManager<[BlockedUser]>.request(route: .getBlockedUser)
            .sink { completion in
                self.isFetching = false
                switch completion {
                case .finished:
                    print("Succeed to request getMyLikeTripCompanions!")
                case .failure(let error):
                    print("Failed to request getMyLikeTripCompanions.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] blockedUsers in
                self?.blockedUsers = blockedUsers
            }.store(in: &cancellables)
    }
    
    func unBlockUser(_ blockedUser: BlockedUser) {
        NetworkManager<Int>.requestWithoutResponse(route: .unBlockUser(memberId: blockedUser.id))
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.fetchBlcokedUsers()
                    print("Succeed to request unBlockUser! \(blockedUser.id)")
                case .failure(let error):
                    print("Failed to request unBlockUser.. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] _ in
                
            }.store(in: &cancellables)
    }
}

extension MyBlockedUsersViewModel {
    static let MOCK_VIEW_MODEL = MyBlockedUsersViewModel(blockedUsers: [])
}
