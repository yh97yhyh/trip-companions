//
//  CustomDatePickerView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var startDate: Date
    //    @Binding var endDate: Date
    //    @State var showingStartDatePicker = true
    //    @State var showingEndDatePicker = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("날짜 입력")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(.gray999999)
                    }
                }
                .padding(.bottom)
                
                Divider()
                    .padding(.bottom)
                
                // MARK: - Add DatePicker
                VStack(alignment: .leading) {
                    //                    HStack {
                    //                        Text("시작 날짜")
                    //                        Spacer()
                    //                        Text(startDate.toDateText())
                    //                            .font(.headline)
                    //                            .modifier(ProfileFeatureTextModifier())
                    //                    }
                    //                    .onTapGesture {
                    //                        showingStartDatePicker.toggle()
                    //                        showingEndDatePicker = false
                    //                    }
                    
                    //                    if showingStartDatePicker {
                    //                        DatePicker("시작 날짜를 선택해주세요", selection: $startDate, displayedComponents: .date)
                    //                            .datePickerStyle(GraphicalDatePickerStyle())
                    //                            .tint(Color.orangeF49321)
                    //                    }
                    DatePicker("날짜를 선택해주세요", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .tint(Color.orangeF49321)
                }
                .padding(.bottom)
                
                //                VStack(alignment: .leading) {
                //                    HStack {
                //                        Text("끝 날짜")
                //                        Spacer()
                //                        Text(endDate.toDateText())
                //                            .font(.headline)
                //                            .modifier(ProfileFeatureTextModifier())
                //                    }
                //                    .onTapGesture {
                //                        showingEndDatePicker.toggle()
                //                        showingStartDatePicker = false
                //                    }
                //
                //                    if showingEndDatePicker {
                //                        DatePicker("끝 날짜를 선택해주세요", selection: $endDate, in: startDate..., displayedComponents: .date)
                //                            .datePickerStyle(GraphicalDatePickerStyle())
                //                            .tint(Color.orangeF49321)
                //                            .onChange(of: endDate) { newEndDate in
                //                                if newEndDate < startDate {
                //                                    endDate = startDate
                //                                }
                //                            }
                //
                //                    }
                //                }
                //                .padding(.bottom)
            }
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("날짜 선택 완료")
            }
            .buttonStyle(CompleButtonStyle(isComplete: true))
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct CustomDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State private var startDate = Date()
        //        @State private var endDate = Date()
        
        var body: some View {
            //            CustomDatePickerView(startDate: $startDate, endDate: $endDate)
            CustomDatePickerView(startDate: $startDate)
            
        }
    }
}

//#Preview {
//    @State var startDate = Date()
//    @State var endDate = Date()
//
//    CustomDatePickerView(startDate: $startDate, endDate: $endDate)
//}
