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
    let id: UUID

    /// The name of the habit (e.g., "Morning Exercise")
    var name: String

    /// Optional detailed description of the habit
    var description: String?

    /// The color associated with this habit
    var color: Color

    /// Date when this habit was created
    let createdAt: Date

    // MARK: Initializer

    /// Creates a new Habit with default values
    /// - Parameters:
    ///   - id: Unique identifier (defaults to new UUID)
    ///   - name: Habit name
    ///   - description: Optional description
    ///   - color: Color for the habit (defaults to green)
    ///   - createdAt: Creation date (defaults to now)
    init(
        id: UUID = UUID(),
        name: String,
        description: String? = nil,
        color: Color = .green,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.color = color
        self.createdAt = createdAt
    }
}

// MARK: - Preview Helper
#if DEBUG
extension Habit {
    /// Sample habits for testing and previews
    static let sampleHabits: [Habit] = [
        Habit(name: "Morning Exercise", description: "30 minutes of cardio", color: .blue),
        Habit(name: "Drink Water", description: "8 glasses per day", color: .cyan),
        Habit(name: "Read a Book", description: "Read for 20 minutes", color: .orange),
        Habit(name: "Meditate", description: "10 minutes of meditation", color: .purple),
        Habit(name: "Journal", description: "Write daily reflections", color: .pink)
    ]
}
#endif
