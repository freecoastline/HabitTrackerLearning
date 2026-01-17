//
//  CardView.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/17.
//

import Foundation
import SwiftUI

struct CardView <Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
        }
        .padding()
        .background(.background)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    CardView {
        Text("Text")
        Text("More")
    }
}
