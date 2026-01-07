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
        guard let index = firstIndex(where: { $0.id == habit.id }) else {
            return nil
        }
        return binding[index]
    }
}


extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double((rgb & 0x0000FF)) / 255
        
        self.init(red: r, green: g, blue: b)
    }
    
    func toHex() -> String? {
        return nil
    }
}
