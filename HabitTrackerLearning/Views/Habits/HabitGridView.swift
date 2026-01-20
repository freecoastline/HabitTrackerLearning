//
//  HabitGridView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/19.
//

import Foundation
import SwiftUI

struct HabitGridView: View {
    let habit: Habit
    let weeks: Int = 12
    private var dates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        var allDates: [Date] = []
        for dateOffset in (0...(weeks * 7)).reversed() {
            if let date = calendar.date(byAdding: .day, value: -dateOffset, to: today) {
                allDates.append(date)
            }
        }
        return allDates
    }
    
    private func cellColor(for date: Date) -> Color {
        if habit.isCheckedIn(for: date) {
            return habit.color.opacity(0.8)
        } else {
            return Color.gray.opacity(0.1)
        }
    }
    
    var body: some View {
        let colunms = Array(repeating: GridItem(.fixed(12), spacing: 3), count: weeks)
        LazyVGrid(columns: colunms) {
            ForEach(dates, id: \.self) { date in
                RoundedRectangle(cornerRadius: 2.0)
                    .fill(cellColor(for: date))
                    .frame(width: 12, height: 12)
            }
        }
    }
}
