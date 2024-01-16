//
//  QuizViewModel.swift
//  Greece
//
//  Created by mnats on 09.01.2024.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    @AppStorage("currentNumber") var currentQuestionNumber: Int = 0
    
    @Published var isFinished = false
    
    var topic: Topic? = nil
    
    var questions: [Question] = []
    
    var currentQuestion: Question {
        questions[currentQuestionNumber]
    }
    
    init(topic: Topic? = nil) {
        self.topic = topic
        if let topic {
            self.questions = Constants.questions.filter({$0.topic == topic})
        } else {
            self.questions = Constants.questions
        }
        self.currentQuestionNumber = 0
        self.isFinished = false
    }
    
    func restart() {
//        questions = []
//        if let topic {
//            questions = Constants.questions.filter({$0.topic == topic})
//        } else {
//            questions = Constants.questions
//        }
        currentQuestionNumber = 0
        isFinished = false
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        return answer == currentQuestion.correctAnswer
    }
    
    func nextQuestion() {
        if currentQuestionNumber + 1 < questions.count - 1 {
            currentQuestionNumber += 1
        } else {
            isFinished = true
        }
    }
}
