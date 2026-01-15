//
//  HabitListViewModel.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/14.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class HabitListViewModel {
    var modelContext: ModelContext?
    // MARK: - Delet
    func deleteHabit(_ habit: Habit) {
        guard let modelContext else { return }
        modelContext.delete(habit)
        try? modelContext.save()
    }
    
    func addHabit(name: String, description: String?, color: Color) {
        guard let modelContext else { return }
        let habit = Habit(name: name, habitDescription: description, color: color)
        modelContext.insert(habit)
        try? modelContext.save()
    }
    
    func seeSampleData(habits: [Habit]) {
        guard let modelContext else { return }
        if habits.isEmpty {
            for sampleHabit in Habit.sampleHabits {
                modelContext.insert(sampleHabit)
            }
            try? modelContext.save()
        }
    }
    
}
