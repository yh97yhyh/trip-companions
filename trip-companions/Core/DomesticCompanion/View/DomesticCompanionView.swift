//
//  DomesticCompanionView.swift
//  trip-companions
//
//  Created by 영현 on 8/7/24.
//

import SwiftUI

struct DomesticCompanionView: View {
    @StateObject var viewModel: DomesticCompanionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("국내동행")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                HStack {
                    NavigationLink(destination: SearchView(viewModel: SearchViewModel.MOCK_VIEW_MODEL)) {
                        Image(systemName: "slider.horizontal.3")
                        Text("필터")
                    }
                    .foregroundColor(.black)
                }
                .fontWeight(.semibold)
                
//                // MARK: - Update to add options
//                ScrollView(.horizontal, showsIndicators: false) {
//                    
//                }
            }
            .padding(.bottom)
            
            DividerView()
                .padding(.horizontal, -16)
            
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.tripCompanions, id: \.self) { tripCompanion in
                        NavigationLink(destination: TripCompanionDetailView(viewModel: TripCompanionDetailViewModel(tripCompanion: tripCompanion))) {
                            TripCompanionCellView(viewModel: TripCompanionCellViewModel(tripCompanion: tripCompanion, thumbnail: nil))
                                .padding(.vertical, 12)
                        }
                        Divider()
                    }
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DomesticCompanionView(viewModel: DomesticCompanionViewModel.MOCK_VIEW_MODEL)
}
