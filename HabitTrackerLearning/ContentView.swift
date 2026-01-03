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
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.orange)
            Text("My Habit Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack(spacing: 30) {
                VStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text("Streak")
                        .font(.caption)
                }
                
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Streak")
                        .font(.caption)
                }
                
                VStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.green)
                    Text("Done")
                        .font(.caption)
                }
                
            }
            .font(.system(size: 30))
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
