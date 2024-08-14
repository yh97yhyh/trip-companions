//
//  TripCompanionCellView.swift
//  trip-companions
//
//  Created by 영현 on 8/14/24.
//

import SwiftUI

struct TripCompanionCellView: View {
    @StateObject var viewModel: TripCompanionCellViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("defaultThumbnail")
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                    Text(viewModel.text)
                        .foregroundColor(.gray767676)
                    if viewModel.startDate == viewModel.endDate {
                        HStack {
                            Image(systemName: "calendar")
                            Text(viewModel.toDateText(viewModel.startDate))
                        }
                        .foregroundColor(.gray767676)
                    } else {
                        HStack {
                            Image(systemName: "calendar")
                            Text("\(viewModel.toDateText(viewModel.startDate) ) ~ \(viewModel.toDateText(viewModel.endDate) )")
                        }
                        .foregroundColor(.gray767676)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    TripCompanionCellView(viewModel: TripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
