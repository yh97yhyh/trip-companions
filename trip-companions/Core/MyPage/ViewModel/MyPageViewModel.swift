//
//  MyPageViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import Foundation
import Alamofire
import Combine

class MyPageViewModel: ObservableObject {
    @Published var member: Member
    @Published var image: UIImage? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    init(member: Member) {
        self.member = member
    }
    
    func updateProfileImage() {
        NetworkManager<Member>.requestFormData(route: .updateProfileImage(profileImageFile: image ?? nil))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            } receiveValue: { [weak self] updatedMember in
                print("succeed to updateProfileImage! \(updatedMember.profileImageUrl ?? nil)")
                AuthManager.shared.currentMember = updatedMember
                self?.member = updatedMember
                self?.image = nil
            }.store(in: &cancellables)
    }
}

extension MyPageViewModel {
    static let MOCK_VIEW_MODEL = MyPageViewModel(member: Member.Guest)
}
