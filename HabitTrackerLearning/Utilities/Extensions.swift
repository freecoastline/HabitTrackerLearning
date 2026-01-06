//
//  Extensions.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/6.
//

import Foundation
import SwiftUI

extension Array where Element == Habit {
    func binding(for habit: Habit, in binding: Binding<[Habit]>) -> Binding<Habit>? {
        guard let index = binding.firstIndex(where: { $0.id == habit.id }) else {
            return nil
        }
        return binding[index]
    }
}
