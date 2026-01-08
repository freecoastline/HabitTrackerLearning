//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var checkedHabits: Set<UUID> = []
    @Query private var habits:[Habit]
    @State private var showingAddHabit: Bool = false
    @State private var habitToEdit: Habit?
    @Environment(\.modelContext) private var modelContext
    
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
                            modelContext.delete(habit)
                            try? modelContext.save()
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
                AddHabitView()
            }
            .sheet(item: $habitToEdit) { habitToEdit in
                EditHabitView(habit: Binding(get: { habitToEdit }, set: { _ in }))
            }
        }.task {
            if habits.isEmpty {
                for sampleHabit in Habit.sampleHabits {
                    modelContext.insert(sampleHabit)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
