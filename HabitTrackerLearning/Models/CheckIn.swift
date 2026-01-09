//
//  CheckIn.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/9.
//
import SwiftData
import UIKit

@Model
class CheckIn {
    var id: UUID
    var date: Date
    var habit: Habit?
    init(id: UUID, date: Date, habit: Habit? = nil) {
        self.id = id
        self.date = date
        self.habit = habit
    }
}
