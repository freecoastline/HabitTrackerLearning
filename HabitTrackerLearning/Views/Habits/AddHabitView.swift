//
//  AddHabitView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/4.
//

import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedColor: Color = .green
    
    var body: some View {
        NavigationStack {
            Form {
                HabitFormFields(name: $name, description: $description, selectorColor: $selectedColor)
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newHabit = Habit(name: name, habitDescription: description, color: selectedColor)
                        modelContext.insert(newHabit)
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
    AddHabitView().modelContainer(for: Habit.self)
}
