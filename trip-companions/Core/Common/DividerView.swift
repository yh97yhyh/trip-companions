//
//  DividerView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.grayF1F1F1)
                .frame(width: nil, height: 12)
        }
    }
}

#Preview {
    DividerView()
}
