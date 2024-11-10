//
//  CustomDatePickerView.swift
//  trip-companions
//
//  Created by 영현 on 8/15/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var startDate: Date?
    @State var selectDate: Date = Date()
    @State var showingNewDatePickAlert = false
    //    @Binding var endDate: Date
    //    @State var showingStartDatePicker = true
    //    @State var showingEndDatePicker = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
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
                            DatePicker("날짜를 선택해주세요", selection: $selectDate, in: Date()..., displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .tint(Color.orangeF49321)
                                .environment(\.locale, Locale(identifier: String(Locale.preferredLanguages[0])))
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
                }
                .padding()
                
                Button {
                    startDate = selectDate
                    dismiss()
//                    if isStartDateBeforeToday() {
//                        showingNewDatePickAlert = true
//                    } else {
//                        startDate = selectDate
//                        dismiss()
//                    }
                } label: {
                    Text("날짜 선택 완료")
                }
                .buttonStyle(CompleButtonStyle(isComplete: true))
                .padding(.horizontal)
            }
            
            if showingNewDatePickAlert {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                NewDatePickAlertView(showingAlert: $showingNewDatePickAlert)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func isStartDateBeforeToday() -> Bool {
        guard let startDate = startDate else {
            return false // startDate가 nil인 경우
        }
        
        let calendar = Calendar.current
        let koreaTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let today = calendar.startOfDay(for: Date()) // 오늘의 시작 시점 (년, 월, 일만)
        let startDay = calendar.startOfDay(for: startDate) // startDate의 시작 시점 (년, 월, 일만)
        
        return startDay < today // startDate가 오늘보다 이전인지 비교
    }
}

//struct CustomDatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewWrapper()
//    }
//    
//    struct PreviewWrapper: View {
//        @State private var startDate = Date()
//        //        @State private var endDate = Date()
//        
//        var body: some View {
//            //            CustomDatePickerView(startDate: $startDate, endDate: $endDate)
//            CustomDatePickerView(startDate: $startDate)
//            
//        }
//    }
//}

//#Preview {
//    CustomDatePickerView()
//}

