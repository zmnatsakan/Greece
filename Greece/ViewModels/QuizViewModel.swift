//
//  QuizViewModel.swift
//  Greece
//
//  Created by mnats on 09.01.2024.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @AppStorage("currentNumber") var currentQuestionNumber: Int = 0
    var questions: [Question] = []
    
    var currentQuestion: Question {
        questions[currentQuestionNumber]
    }
    
    init() {
        self.questions = Constants.questions
        self.currentQuestionNumber = 0
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        return answer == currentQuestion.correctAnswer
    }
    
    func nextQuestion() {
        if currentQuestionNumber + 1 < questions.count - 1 {
            currentQuestionNumber += 1
        }
    }
}
