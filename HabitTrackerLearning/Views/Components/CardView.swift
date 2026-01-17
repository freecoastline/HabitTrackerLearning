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
        content
    }
}

#Preview {
    CardView {
        Text("Text")
        Text("More")
    }
}
