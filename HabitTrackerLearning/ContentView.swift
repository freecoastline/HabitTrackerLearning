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
    @Environment(HabitListViewModel.self) var viewModel
    
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
        }
        .onAppear(perform: {
            viewModel.modelContext = modelContext
        })
        .task {
            viewModel.seeSampleData(habits: habits)
        }
    }
}

#Preview {
    var viewModel = HabitListViewModel()
    ContentView().modelContainer(for: [Habit.self, CheckIn.self], inMemory: true).environment(viewModel)
}
