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
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.green)

                            Text(habit)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Track your progress here!")
                                .foregroundColor(.secondary)
                            Spacer()
                        }
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
