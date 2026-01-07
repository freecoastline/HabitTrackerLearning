//
//  PreviewHelper.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/6.
//

import Foundation
import SwiftUI

#if DEBUG
extension Habit {
    static var preview: Habit {
        Habit(
             name: "Morning Exercise",
             habitDescription: "30 minutes of cardio",
             color: .blue
         )
    }
    
    static var previewNoDescription: Habit {
        Habit(
            name: "Drink Water",
            color: .cyan
        )
    }
}

struct PreviewData {
    static func habits(count: Int = 5) -> [Habit] {
        Array(Habit.sampleHabits.prefix(count))
    }
    
    static func checkedHabits(from habits: [Habit], percentChecked: Double = 0.5) -> Set<UUID> {
        let countToCheck = Int(Double(habits.count) * percentChecked)
        return Set(habits.prefix(countToCheck).map(\.id))
    }
}

#endif // DEBUG
