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
        NavigationStack {
            List {
                ForEach(habits, id: \.self) { habit in
                    NavigationLink {
                        Text("Detail for \(habit)")
                            .font(.largeTitle)
                    } label: {
                        HStack {
                            Image(systemName: "circle")
                                .foregroundStyle(.green)
                            Text(habit)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("My habits")
        }
    }
}

#Preview {
    ContentView()
}
