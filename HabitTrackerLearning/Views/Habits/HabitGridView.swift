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
    
    var body: some View {
        
    }
}
