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
                
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
            }
        }
    }
    
}
