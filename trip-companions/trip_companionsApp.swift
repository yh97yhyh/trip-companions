//
//  trip_companionsApp.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

@main
struct trip_companionsApp: App {
    @StateObject var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
