//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI

struct ContentView: View {
    @State private var checkedHabits: Set<UUID> = []
    @State private var habits:[Habit] = Habit.sampleHabits
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    NavigationLink {
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.green)

                            Text(habit.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Track your progress here!")
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    } label: {
                        HabitRowView(habit: habit, isChecked: Binding(get: {
                            checkedHabits.contains(habit.id)
                        }, set: { isChecked in
                            if isChecked {
                                checkedHabits.insert(habit.id)
                            } else {
                                checkedHabits.remove(habit.id)
                            }
                        }))
                    }
                }
            }
            .navigationTitle("My habits")
        }
    }
}

#Preview {
    ContentView()
}
