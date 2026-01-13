//
//  CheckInHistoryView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/13.
//

import Foundation
import SwiftUI
import SwiftData

struct CheckInHistoryView: View {
    let habit: Habit
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        
    }
}

#Preview {
    CheckInHistoryView(habit: Habit.sampleHabits[0]).modelContainer(for: [Habit.self, CheckIn.self], inMemory: true)
}
