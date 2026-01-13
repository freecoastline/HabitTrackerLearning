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
    @State private var showingDatePicker = false
    @State private var selectedDate = Date()
    
    private var isCheckInToday: Bool {
        habit.isCheckedIn(for: Date())
    }
    
    private var isSelectedDateChecked: Bool {
        habit.isCheckedIn(for: selectedDate)
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
        .onLongPressGesture {
            selectedDate = Date()
            showingDatePicker = true
        }
        .sheet(isPresented: $showingDatePicker) {
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Select a date to check in")
                        .font(.headline)

                    DatePicker("Date", selection: $selectedDate, in: ...Date() ,displayedComponents: .date)
                        .datePickerStyle(.graphical).padding()
                    Spacer()
                }
                .navigationTitle("Check-in Date")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel") {
                            showingDatePicker = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(isSelectedDateChecked ? "remove checkIn" : "Check In") {
                            habit.toggleCheckIn(for: selectedDate, context: modelContext)
                            showingDatePicker = false
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    List {
        HabitRowView(habit: Habit.sampleHabits[0])
        HabitRowView(habit: Habit.sampleHabits[1])
    }.modelContainer(for: [Habit.self, CheckIn.self], inMemory: true)
}
