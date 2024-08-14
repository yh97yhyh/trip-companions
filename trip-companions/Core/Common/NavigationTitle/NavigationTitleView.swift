//
//  NavigationTitleView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct NavigationTitleView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationTitleView()
}
