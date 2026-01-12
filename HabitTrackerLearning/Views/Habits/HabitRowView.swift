//
//  HabitRowView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/4.
//

import SwiftUI
import SwiftData

// MARK: - HabitRowView
/// A reusable row component for displaying a single habit in a list
/// This demonstrates component extraction and @Binding for parent-child communication
struct HabitRowView: View {
    let habit: Habit
    @Environment(\.modelContext) var modelContext
    
    private var isCheckInToday: Bool {
        habit.isCheckedIn(for: Date())
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                habit.toggleCheckIn(for: Date(), context: modelContext)
            } label: {
                Image(systemName: isCheckInToday ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(habit.color)
            }
            .buttonStyle(.plain)
            VStack(alignment: .leading) {
                Text(habit.name)
                if let description = habit.habitDescription, !description.isEmpty {
                    Text(description)
                }
            }
            Spacer()
            Circle()
                .fill(habit.color)
                .frame(width: 12, height: 12)
        }
    }
}

#Preview {
    List {
        HabitRowView(habit: Habit.sampleHabits[0])
        HabitRowView(habit: Habit.sampleHabits[1])
    }.modelContainer(for: [Habit.self, CheckIn.self], inMemory: true)
}
