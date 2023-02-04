//
//  CalendarView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    var year: Int
    var month: Int
    let currentDay = DateUtil.getCurrentDay()
   
    //첫번째 요일 구하기
    var firstWeekday: Int {
        let dateComponents = DateComponents(year: year, month: month, day: 1)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return calendar.component(.weekday, from: date)
    }
    
    var totalDay : Int {
        return calendarDays(year: year, month: month) + self.firstWeekday - 1
    }
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Sun")
                Text("Mon")
                Text("Tue")
                Text("Wed")
                Text("Thu")
                Text("Fri")
                Text("Sat")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal)
            .background(Color.yellow)
            
            ForEach(0 ..< 6, id: \.self) { row in
                HStack {
                    ForEach(1...7, id: \.self) { column in
                        let pivot = 7 * row + column
                        let day = pivot - self.firstWeekday + 1

                       // if pivot >= self.firstWeekday && pivot <= totalDay{
//                            if currentDay <= day{
//                                Text("\(day)")
//                                    .frame(width: 40, height: 40)
//                                    .background(currentDay == day ? Color.yellow : Color.blue)
//                            }
////                            else{
//                                Text("\(day)")
//                                    .frame(width: 40, height: 40)
//                                    .background(Color.gray)
//                            }
//                        } else {
//                            Text("")
//                                .frame(width: 40, height: 40)
//                                .background(Color.black)
                      //  }
                    }
                }
            }
        }
    }
    
    
    
    //일일 범위
    func calendarDays(year: Int, month: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(year: 2023, month: 2)
    }
}
