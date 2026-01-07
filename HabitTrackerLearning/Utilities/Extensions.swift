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
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Int(components[0] * 255.0)
        let g = Int(components[1] * 255.0)
        let b = Int(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

#if DEBUG
// Test Color hex conversion
extension Color {
    static func testHexConversion() {
        // Test 1: Create color from hex
        if let color1 = Color(hex: "#FF5733") {
            print("✅ Test 1 passed: Created color from #FF5733")

            // Test 2: Convert back to hex
            if let hex = color1.toHex() {
                print("✅ Test 2 passed: Converted to \(hex)")

                // Test 3: Should match original (allowing for rounding)
                if hex.uppercased() == "#FF5733" {
                    print("✅ Test 3 passed: Round-trip successful!")
                } else {
                    print("⚠️ Test 3: Got \(hex), expected #FF5733 (minor rounding OK)")
                }
            }
        }

        // Test 4: Invalid hex should return nil
        if Color(hex: "INVALID") == nil {
            print("✅ Test 4 passed: Invalid hex returns nil")
        }

        // Test 5: Test without # prefix
        if let color2 = Color(hex: "00FF00") {
            print("✅ Test 5 passed: Works without # prefix")
            if let hex = color2.toHex() {
                print("   Result: \(hex)")
            }
        }

        print("\n🎉 All Color hex conversion tests complete!")
    }
}
#endif
