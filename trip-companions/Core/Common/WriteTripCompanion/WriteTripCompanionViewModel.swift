//
//  WriteTripCompanionViewModel.swift
//  trip-companions
//
//  Created by 영현 on 8/18/24.
//

import Foundation
import Combine
import Alamofire

class WriteTripCompanionViewModel: ObservableObject {
    static let shared = WriteTripCompanionViewModel()
    
    @Published var region: Region? = nil {
        didSet {
            validateForm()
        }
    }
    @Published var startDate: Date? = nil {
        didSet {
            validateForm()
        }
    }
//    @Published var endDate = Date.defaultDate() {
//        didSet {
//            validateForm()
//        }
//    }
    @Published var personal: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var title: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var contents: String = "" {
        didSet {
            validateForm()
        }
    }
    @Published var openKakaoUrl: String = "" {
        didSet {
//            openKakaoUrl = self.openKakaoUrl.trimmingCharacters(in: .whitespacesAndNewlines)
            validateForm()
        }
    }
    @Published var isSameMbti: Bool? = nil
    @Published var isMale: Bool? = nil
    @Published var isDrinker: Bool? = nil
    @Published var isSmoker: Bool? = nil
    
    @Published var isComplete: Bool = false

    private func validateForm() {
        isComplete = region != nil &&
        startDate != nil &&
        !personal.isEmpty &&
        !title.isEmpty &&
        !contents.isEmpty &&
        isValidURL(openKakaoUrl)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(region: Region? = nil, startDate: Date? = nil, personal: String = "", title: String = "", contents: String = "", openKakaoUrl: String = "", isSameMbti: Bool? = nil, isMale: Bool? = nil, isDrinker: Bool? = nil, isSmoker: Bool? = nil) {
        self.region = region
        self.startDate = startDate
//        self.endDate = endDate
        self.personal = personal
        self.title = title
        self.contents = contents
        self.openKakaoUrl = openKakaoUrl
        self.isSameMbti = isSameMbti
        self.isMale = isMale
        self.isDrinker = isDrinker
        self.isSmoker = isSmoker
    }
    
    func createTripCompanion() {
        var categoriesId: [Int] = []
        
        if isSameMbti != nil {
            isSameMbti! ? categoriesId.append(1) : categoriesId.append(2)
        }
        if isMale != nil {
            isMale! ? categoriesId.append(3) : categoriesId.append(4)
        }
        if isDrinker != nil {
            isDrinker! ? categoriesId.append(5) : categoriesId.append(6)
        }
        if isSmoker != nil {
            isSmoker! ? categoriesId.append(7) : categoriesId.append(8)
        }
        
        let parameters: Parameters = [
            "title": title,
            "regionId": region!.id,
            "tripDate": startDate!.toServerDateText(),
            "companionMemberCount": personal,
            "contents": contents,
            "categoriesId": categoriesId,
            "openKakaoUrl": openKakaoUrl.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        
        NetworkManager<TripCompanion>.request(route: .createTripCompanion(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request createTripCompanion!")
                case .failure(let error):
                    print("Failed to request createTripCompanion.. \(error.localizedDescription)")
                }
            } receiveValue: { tripCompanion in
                print("Succeed to create trip companion! \(tripCompanion.id)")
            }.store(in: &cancellables)
    }
    
    func updateTripCompanion(postId: Int) {
        var categoriesId: [Int] = []
        
        if isSameMbti != nil {
            isSameMbti! ? categoriesId.append(1) : categoriesId.append(2)
        }
        if isMale != nil {
            isMale! ? categoriesId.append(3) : categoriesId.append(4)
        }
        if isDrinker != nil {
            isDrinker! ? categoriesId.append(5) : categoriesId.append(6)
        }
        if isSmoker != nil {
            isSmoker! ? categoriesId.append(7) : categoriesId.append(8)
        }
        
        let parameters: Parameters = [
            "tripCompanionId": postId,
            "title": title,
            "regionId": region!.id,
            "tripDate": startDate!.toServerDateText(),
            "companionMemberCount": personal,
            "contents": contents,
            "categoriesId": categoriesId
            
        ]
        
        NetworkManager<TripCompanion>.request(route: .updateTripCompanion(parameters))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed to request updateTripCompanion!")
                case .failure(let error):
                    print("Failed to request updateTripCompanion.. \(error.localizedDescription)")
                }
            } receiveValue: { tripCompanion in
                print("Succeed to update trip companion! \(tripCompanion.id)")
            }.store(in: &cancellables)
    }
    
    func clear() {
        self.region = nil
        self.startDate = nil
        self.personal = ""
        self.title = ""
        self.contents = ""
        self.isSameMbti = nil
        self.isMale = nil
        self.isDrinker = nil
        self.isSmoker = nil
        self.isComplete = false
        self.openKakaoUrl = ""
    }
    
    func isValidURL(_ string: String) -> Bool {
        if let url = URL(string: string) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}



extension WriteTripCompanionViewModel {
    static let MOCK_VIEW_MODEL = WriteTripCompanionViewModel()
}
