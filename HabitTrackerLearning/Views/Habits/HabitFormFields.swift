//
//  HabitFormFields.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/17.
//

import Foundation
import SwiftUI

struct HabitFormFields: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var selectorColor: Color
    
    var body: some View {
        Section {
            TextField("Habit name", text: $name)
        } header: {
            Text("Name")
        }
        
        Section {
            TextEditor(text: $description)
                .frame(height: 100)
        }
        
        Section {
            ColorPicker("Choose a Color", selection: $selectorColor)
        } header: {
            Text("Color")
        }
    }
}
