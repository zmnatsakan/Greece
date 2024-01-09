//
//  ContentView.swift
//  Greece
//
//  Created by mnats on 27.12.2023.
//

import SwiftUI

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
}

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

struct QuizView: View {
    @ObservedObject var viewModel = QuizViewModel()
    @State private var selectedOption: String? = nil
    
    var body: some View {
        VStack {
            Text(viewModel.currentQuestion.text)
                .font(.headline)
                .frame(height: 100)
            
            VStack {
                ForEach(viewModel.currentQuestion.options, id: \.self) { option in
                    Button {
                        selectedOption = option
                    } label: {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundStyle(
                                        selectedOption == option ? (viewModel.checkAnswer(option) ? Color.green : Color.red) : .gray
                                    )
                                    .opacity(0.3)
                            }
                            .tint(.primary)
                            .bold()
                    }
                }
                Button {
                    selectedOption = nil
                    viewModel.nextQuestion()
                } label: {
                    Text("Next question")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                        .tint(.primary)
                        .bold()
                }
                .disabled(selectedOption == nil)
                .opacity(selectedOption == nil ? 0 : 1)
                
                Button("reset") {
                    viewModel.currentQuestionNumber = 0
                }
            }
        }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: QuizView()) {
                    Text("Quiz")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                        .tint(.white)
                }
                NavigationLink(destination: TreeView()) {
                    Text("Persons")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                        .tint(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
