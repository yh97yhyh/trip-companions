//
//  NavigationTitleView.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

struct NavigationTitleView: View {
    @Environment(\.dismiss) private var dismiss
    var title: String
    var isFilter: Bool = false
    
    var body: some View {
        HStack {
            Button {
                if isFilter {
                    
                }
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
            Spacer()
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationTitleView(title: "테스트")
}
