//
//  EditHabitView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/5.
//

import Foundation
import SwiftUI

struct EditHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var habit: Habit
    @State private var name: String
    @State private var description: String
    @State private var selectedColor: Color
    
    init(habit: Binding<Habit>) {
        _habit = habit
        _name = State(initialValue: habit.wrappedValue.name)
        _description = State(initialValue: habit.wrappedValue.habitDescription ?? "")
        _selectedColor = State(initialValue: Color(habit.wrappedValue.color))
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
                        habit.colorHex = selectedColor.toHex() ?? "#4CAF50"
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    EditHabitView(habit: .constant(Habit(name: "ddd")))
}
