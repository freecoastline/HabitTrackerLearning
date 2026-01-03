//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI

struct ContentView: View {
    @State private var checkedHabits: Set<String> = []
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
                            Button {
                                if checkedHabits.contains(habit) {
                                    checkedHabits.remove(habit)
                                } else {
                                    checkedHabits.insert(habit)
                                }
                            } label: {
                                Image(systemName: checkedHabits.contains(habit) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.green)
                            }
                            .buttonStyle(.plain)
                            
                            Text(habit)
                                .font(.headline)
                            
                            Spacer()
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
