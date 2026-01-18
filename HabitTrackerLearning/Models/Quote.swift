//
//  Quote.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/18.
//

import Foundation


struct Quote: Codable {
    let q: String
    let a: String
    var text:String { q }
    var author: String { a}
}
