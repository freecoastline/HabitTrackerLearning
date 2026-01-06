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
    @State private var showingAddHabit: Bool = false
    @State private var habitToEdit: Habit?
    
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
                    .swipeActions {
                        Button {
                            habitToEdit = habit
                        } label: {
                            Label("Edit Habit", systemImage: "pencil")
                        }
                        .tint(.blue)

                        Button("delete", role: .destructive) {
                            habits.removeAll {
                                $0.id == habit.id
                            }
                            checkedHabits.remove(habit.id)
                        }
                    }
                }

            }
            .navigationTitle("My habits")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habits: $habits)
            }
            .sheet(item: $habitToEdit) { habitToEdit in
                if let bindingHabit = habits.binding(for: habitToEdit, in: $habits) {
                    EditHabitView(habit: bindingHabit)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
