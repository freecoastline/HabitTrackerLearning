//
//  HabitTrackerLearningApp.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerLearningApp: App {
    @State private var viewModel = HabitListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(viewModel)
        }
        .modelContainer(for: [Habit.self, CheckIn.self])
    }
}
