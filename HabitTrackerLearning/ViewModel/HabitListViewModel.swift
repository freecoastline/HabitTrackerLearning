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
    private let modelContext: ModelContext
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Delet
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
        try? modelContext.save()
    }
    
    func addHabit(name: String, description: String?, color: Color) {
        let habit = Habit(name: name, habitDescription: description, color: color)
        modelContext.insert(habit)
        try? modelContext.save()
    }
    
    func seeSampleData
    
}
