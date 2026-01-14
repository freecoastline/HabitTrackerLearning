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
    private var sortedCheckIns: [CheckIn] {
        habit.checkIns.sorted { $0.date > $1.date }
    }
    
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedCheckIns) { CheckIn in
                    
                }
            }
            .navigationTitle("Check-In History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CheckInHistoryView(habit: Habit.sampleHabits[0]).modelContainer(for: [Habit.self, CheckIn.self], inMemory: true)
}
