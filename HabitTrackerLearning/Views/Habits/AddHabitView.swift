//
//  AddHabitView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/4.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var habits: [Habit]
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedColor: Color = .green
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Haibit name", text: $name)
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
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    AddHabitView(habits: .constant([]))
}
