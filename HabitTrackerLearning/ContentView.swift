//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var habits:[Habit]
    @State private var showingAddHabit: Bool = false
    @State private var habitToEdit: Habit?
    @Environment(\.modelContext) private var modelContext
    lazy var viewModel = HabitListViewModel(modelContext: modelContext)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    NavigationLink {
                        CheckInHistoryView(habit: habit)
                    } label: {
                        HabitRowView(habit: habit)
                    }
                    .swipeActions {
                        Button {
                            habitToEdit = habit
                        } label: {
                            Label("Edit Habit", systemImage: "pencil")
                        }
                        .tint(.blue)

                        Button("delete", role: .destructive) {
                            viewModel.deleteHabit(habit)
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
                EditHabitView(habit: habitToEdit)
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
