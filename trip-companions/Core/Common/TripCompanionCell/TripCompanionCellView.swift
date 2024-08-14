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
//                if viewModel.thumbnail != nil {
                // MARK: - Update to KFImage
                Image("TripCompanionThumbnailTest")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 69, height: 69)
                    .cornerRadius(10)
                    .padding(.trailing, 12)
//                } else {
//                    Image("defaultThumbnail")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 65, height: 65)
//                        .padding(4)
//                        .background(Color.grayF1F1F1)
//                        .cornerRadius(10)
//                        .padding(.horizontal, 12)
//                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.tripCompanion.title)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack {
                        Text(viewModel.tripCompanion.contents)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(.gray767676)
                        Spacer()
                    }
                    if viewModel.tripCompanion.startDate == viewModel.tripCompanion.endDate {
                        HStack {
                            Image(systemName: "calendar")
//                                .padding(.trailing, 2)
                            Text(viewModel.toDateText(viewModel.tripCompanion.startDate))
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                    } else {
                        HStack {
                            Image(systemName: "calendar")
//                                .padding(.trailing, 2)
                            Text("\(viewModel.toDateText(viewModel.tripCompanion.startDate) ) ~ \(viewModel.toDateText(viewModel.tripCompanion.endDate) )")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray767676)
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    TripCompanionCellView(viewModel: TripCompanionCellViewModel.MOCK_VIEW_MODEL)
}
