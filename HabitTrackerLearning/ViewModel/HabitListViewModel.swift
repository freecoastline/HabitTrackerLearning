//
//  HabitListViewModel.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/14.
//

import Foundation
import SwiftData

@Observable
class HabitListViewModel {
    private let modelContext: ModelContext
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
