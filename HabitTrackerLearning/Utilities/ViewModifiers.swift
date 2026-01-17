//
//  ViewModifiers.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/17.
//

import Foundation
import SwiftUI
 
struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.subheadline).fontWeight(.semibold).textCase(.uppercase)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = .blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding()
            .background(color)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}



extension View {
    func sectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }
}
