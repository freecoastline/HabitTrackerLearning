//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    enum HabitSortOption: String, CaseIterable {
        case name = "Name"
        case dateCreated = "dateCreated"
        
        var sortDescriptor: SortDescriptor<Habit> {
            switch self {
            case .name:
                SortDescriptor(\Habit.name)
            case .dateCreated:
                SortDescriptor(\Habit.createdAt, order: .reverse)
            }
        }
    }
    
    @Query(sort: \Habit.name) private var habits:[Habit]
    private var sortedHabits: [Habit] {
        habits.sorted(using: selectedSort.sortDescriptor)
    }
    @State private var showingAddHabit: Bool = false
    @State private var selectedSort: HabitSortOption = .name
    @State private var habitToEdit: Habit?
    @Environment(\.modelContext) private var modelContext
    @Environment(HabitListViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedHabits) { habit in
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
