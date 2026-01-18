//
//  QuoteService.swift
//  HabitTrackerLearning
//
//  Created by ken on 2026/1/18.
//

import SwiftUI

enum QuoteService {
    private static let apiurl = "https://zenquotes.io/api/random"
    
    static func fetchRandomQuote() async throws -> Quote {
        guard let url = URL(string: apiurl) else {
            throw QuoteError.Invalid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        guard let quote = quotes.first else {
            throw QuoteError.noQuoteFound
        }
        return quote
    }
}


enum QuoteError: Error {
    case Invalid
    case noQuoteFound
}
