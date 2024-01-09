//
//  QuizView.swift
//  Greece
//
//  Created by mnats on 09.01.2024.
//

import SwiftUI

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
