//
//  WriteButtonView.swift
//  trip-companions
//
//  Created by 영현 on 9/24/24.
//

import SwiftUI

struct WriteButtonView: View {
    @Binding var showingNoSignInAlert: Bool
    
    var body: some View {
        VStack {
            if AuthManager.shared.isLoggedIn {
                NavigationLink(destination: WriteTripCompanionView(isWriteMode: true, viewModel: WriteTripCompanionViewModel())) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(24)
                        .background(Color.orangeF49321)
                        .clipShape(Circle())
                }
            } else {
                Button {
                    showingNoSignInAlert = true
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .padding(24)
                        .background(Color.orangeF49321)
                        .clipShape(Circle())
                }
            }
        }
    }
}

//#Preview {
//    WriteButtonView()
//}
