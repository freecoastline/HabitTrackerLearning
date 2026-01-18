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
        let filtered = searchText.isEmpty ? habits : habits.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
        return filtered.sorted(using: selectedSort.sortDescriptor)
    }
    @State private var showingAddHabit: Bool = false
    @State private var selectedSort: HabitSortOption = .name
    @State private var habitToEdit: Habit?
    @Environment(\.modelContext) private var modelContext
    @Environment(HabitListViewModel.self) var viewModel
    
    @State private var searchText: String = ""
    
    @State private var dailyQuote: Quote?
    @State private var isLoadingState = false
    @State private var quoteError: String?
    
    var body: some View {
        NavigationStack {
            List {
                if isLoadingState {
                    ProgressView()
                    Text("Loading State ...")
                        .foregroundStyle(.secondary)
                } else if let error = quoteError {
                    Text(error).foregroundStyle(.red)
                } else if let quote = dailyQuote {
                    Section {
                        VStack(alignment: .leading) {
                            Text("\"\(quote.text)\"")
                                .font(.body)
                                .italic()
                            Text("- \(quote.author)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    } header: {
                        Text("Daily Motivation")
                    }
                }
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
            .searchable(text: $searchText, prompt: "Search habits")
            .navigationTitle("My habits")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        ForEach(HabitSortOption.allCases, id:\.self) { option in
                            Button {
                                selectedSort = option
                            } label: {
                                if selectedSort == option {
                                    Label(option.rawValue, systemImage: "checkmark")
                                } else {
                                    Text(option.rawValue)
                                }
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
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
            isLoadingState = true
            do {
                dailyQuote = try await QuoteService.fetchRandomQuote()
                quoteError = nil
            } catch {
                quoteError = "Failed to load Quote \(error.localizedDescription)"
            }
            isLoadingState = false
        }
    }
}

#Preview {
    var viewModel = HabitListViewModel()
    ContentView().modelContainer(for: [Habit.self, CheckIn.self], inMemory: true).environment(viewModel)
}
