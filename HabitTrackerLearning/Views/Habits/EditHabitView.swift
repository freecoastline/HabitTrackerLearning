//
//  EditHabitView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/5.
//

import Foundation
import SwiftUI
import SwiftData

struct EditHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    let habit: Habit
    @State private var name: String
    @State private var description: String
    @State private var selectedColor: Color
    
    init(habit: Habit) {
        self.habit = habit
        _name = State(initialValue: habit.name)
        _description = State(initialValue: habit.habitDescription ?? "")
        _selectedColor = State(initialValue: habit.color)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit name", text: $name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextEditor(text: $description)
                        .frame(height: 100)
                } header: {
                    Text("Description (Optional)")
                }
                
                Section {
                    ColorPicker("Choose a color", selection: $selectedColor)
                } header: {
                    Text("Color")
                }
            }
            .navigationTitle("Edit habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        habit.name = name
                        habit.habitDescription = description
                        habit.color = selectedColor
                        try? modelContext.save()
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    EditHabitView(habit: Habit(name: "ddd")).modelContainer(for: Habit.self)
}
