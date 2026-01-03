//
//  StateTestView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/4.
//

import Foundation
import SwiftUI

struct StateTestView: View {
    @State private var count = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("count is \(count)")
            Button("Tap ME!") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    StateTestView()
}

