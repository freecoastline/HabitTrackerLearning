//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("My Habit Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    ContentView()
}
