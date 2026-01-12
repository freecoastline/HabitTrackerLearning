//
//  Habit.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/4.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - Habit Model
/// Represents a single habit that the user wants to track
/// Conforms to Identifiable so SwiftUI can track each habit uniquely in Lists
///
@Model
class Habit: Identifiable {
    // MARK: Properties

    /// Unique identifier for this habit
    /// UUID() generates a random unique ID automatically
    @Attribute(.unique) var id: UUID

    /// The name of the habit (e.g., "Morning Exercise")
    var name: String

    /// Optional detailed description of the habit
    var habitDescription: String?

    /// The color associated with this habit
    var colorHex: String

    /// Date when this habit was created
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \CheckIn.habit)
    var checkIns: [CheckIn] = []
    
    // MARK: Initializer

    /// Creates a new Habit with default values
    /// - Parameters:
    ///   - id: Unique identifier (defaults to new UUID)
    ///   - name: Habit name
    ///   - description: Optional description
    ///   - color: Color for the habit (defaults to green)
    ///   - createdAt: Creation date (defaults to now)
    ///
    var color: Color {
        get {
            Color(hex: colorHex) ?? .green
        }
        set {
            colorHex = newValue.toHex() ?? "#4CAF50"
        }
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        habitDescription: String? = nil,
        color: Color = .green,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.habitDescription = habitDescription
        self.colorHex = color.toHex() ?? "#4CAF50"
        self.createdAt = createdAt
    }
    
    // MARK: - Check-in Helper Methods
    func isCheckedIn(for date: Date) -> Bool {
        let calendar = Calendar.current
        return checkIns.contains { CheckIn in
            calendar.isDate(CheckIn.date, inSameDayAs: date)
        }
    }
    
    func checkIn(for date: Date) -> CheckIn? {
        let calendar = Calendar.current
        return checkIns.first { CheckIn in
            calendar.isDate(CheckIn.date, inSameDayAs: date)
        }
    }
    
    func toggleCheckIn(for date: Date, context: ModelContext) {
        if let existingCheckIn = checkIn(for: date) {
            context.delete(existingCheckIn)
        } else {
            let newCheckIn = CheckIn(id: UUID(), date: date, habit: self)
            context.insert(newCheckIn)
        }
        try? context.save()
    }
}

// MARK: - Preview Helper
#if DEBUG
extension Habit {
    /// Sample habits for testing and previews
    static let sampleHabits: [Habit] = [
        Habit(name: "Morning Exercise", habitDescription: "30 minutes of cardio", color: .blue),
        Habit(name: "Drink Water", habitDescription: "8 glasses per day", color: .cyan),
        Habit(name: "Read a Book", habitDescription: "Read for 20 minutes", color: .orange),
        Habit(name: "Meditate", habitDescription: "10 minutes of meditation", color: .purple),
        Habit(name: "Journal", habitDescription: "Write daily reflections", color: .pink)
    ]
}
#endif
