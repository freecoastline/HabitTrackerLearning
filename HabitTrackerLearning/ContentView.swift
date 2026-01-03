//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI

struct ContentView: View {
    let habits = ["Morning Exercise", "Drink Water", "Read a Book", "Meditate", "Journal"]
    var body: some View {
        List {
            ForEach(habits, id: \.self) { habit in
                HStack {
                    Image(systemName: "circle")
                        .foregroundStyle(.green)
                    Text(habit)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
