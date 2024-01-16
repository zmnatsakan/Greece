//
//  Question.swift
//  Greece
//
//  Created by mnats on 09.01.2024.
//
//

import Foundation

enum Topic: String, CaseIterable {
    case greekGods = "Greek Gods"
    case historyFacts = "History Facts"
    case historicalFigures = "Historical Figures"
    case mythologicalStories = "Mythological Stories"
    case philosophyAndLiterature = "Philosophy and Literature"
    case others = "Other"
    
    var bestScore: Int {
        return UserDefaults.standard.integer(forKey: rawValue)
    }
}

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
    let topic: Topic
}
