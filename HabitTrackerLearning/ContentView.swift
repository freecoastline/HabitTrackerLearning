//
//  ContentView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/3.
//

import SwiftUI

struct ContentView: View {
    @State private var checkedHabits: Set<UUID> = []
    @State private var habits:[Habit] = Habit.sampleHabits
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    NavigationLink {
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.green)

                            Text(habit.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Track your progress here!")
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    } label: {
                        HStack {
                            Button {
                                if checkedHabits.contains(habit.id) {
                                    checkedHabits.remove(habit.id)
                                } else {
                                    checkedHabits.insert(habit.id)
                                }
                            } label: {
                                Image(systemName: checkedHabits.contains(habit.id) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.green)
                            }
                            .buttonStyle(.plain)
                            
                            Text(habit.name)
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
