//
//  MainTabViewModel.swift
//  trip-companions
//
//  Created by 영현 on 9/20/24.
//

import Foundation

class MainTabViewModel: ObservableObject {
    static let shared = MainTabViewModel()
    
    @Published var selectedIndex = 0
//        didSet {
//            print("selectedIndex : \(selectedIndex)")
//        }
//    }
}
