//
//  QuizView.swift
//  Greece
//
//  Created by mnats on 09.01.2024.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @ObservedObject var treeViewModel: TreeViewModel
    @State private var selectedOption: String?
    @State private var selectedPerson: PersonDetail?
    
    @State private var questionIndicators: [Bool?] = []
    
    @Environment(\.dismiss) var dismiss
    
    init(topic: Topic? = nil) {
        viewModel = QuizViewModel(topic: topic)
        treeViewModel = TreeViewModel()
        selectedOption = nil
        selectedPerson = nil
    }
    
    func getButtonType(for option: String) -> AnswerButton.AnswerType {
        if selectedOption == option {
            return viewModel.checkAnswer(option) ? .correct : .incorrect
        } else if selectedOption != nil && option == viewModel.currentQuestion.correctAnswer {
            return .correct
        }
        return .notSelected
    }
    
    var body: some View {
        VStack {
            VStack {
                if !viewModel.isFinished {
                    HStack {
                        ForEach(questionIndicators, id: \.self) { result in
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(result == nil ? .gray : (result! ? .green : .red))
                        }
                    }
                    .onAppear {
                        questionIndicators = Array(repeating: nil, count: viewModel.questions.count - 1)
                        print(" COUNT: ",viewModel.questions.count - 1)
                    }
                    
                    Spacer()
                    
                    Text(viewModel.currentQuestion.text)
                        .foregroundStyle(.white)
                        .font(.title)
                        .frame(height: 100)
                        .minimumScaleFactor(0.1)
                        .padding()
                    
                    VStack {
                        ForEach(viewModel.currentQuestion.options, id: \.self) { option in
                            ZStack {
                                Button {
                                    if selectedOption == nil {
                                        selectedOption = option
                                        withAnimation {
                                            questionIndicators[viewModel.currentQuestionNumber] =  viewModel.checkAnswer(option)
                                        }
                                    }
                                } label: {
                                    Text(option)
                                        .answerButton(answerType: getButtonType(for: option))
                                }
                                .disabled(selectedOption != nil)
                                
                                if let person = treeViewModel.persons.first(where: { $0.name == option }), selectedOption != nil {
                                    HStack {
                                        Spacer()
                                        Button {
                                            selectedPerson = person
                                        } label: {
                                            Text("i")
                                                .foregroundStyle(.blue)
                                                .bold()
                                                .padding()
                                                .background {
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .foregroundStyle(.white)
                                                        .aspectRatio(1, contentMode: .fit)
                                                }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
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
                    }
                    .padding(.horizontal)
                } else {
                    let score = questionIndicators.reduce(0) { $0 + ($1 == true ? 1 : 0) }
                    Text("Your result:")
                        .onAppear {
                            let bestScore = UserDefaults.standard.integer(forKey: viewModel.topic?.rawValue ?? "")
                            if score > bestScore {
                                UserDefaults.standard.set(score, forKey: viewModel.topic?.rawValue ?? "")
                            }
                        }
                    Text("\(score) / \(questionIndicators.count)")
                        .font(.system(size: 40).bold())
                    Button {
                        dismiss()
                        viewModel.isFinished = false
                    } label: {
                        Text("Finish")
                            .font(.title)
                            .answerButton(answerType: .notSelected)
                            .padding()
                    }
                    
                    
                }
                
            }
            .container(label: viewModel.topic?.rawValue ?? "Quiz", isBack: true)
            .foregroundStyle(.white)
            .padding()
            .sheet(item: $selectedPerson) { person in
                VStack {
                    PersonDetailView(person: person, viewModel: treeViewModel)
                        .environment(\.isInsideNavigationView, false)
                }
            }
            Spacer()
        }
        .background {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        }
        .onDisappear {
            selectedOption = nil
            selectedPerson = nil
            viewModel.restart()
        }
        .onDisappear {
                questionIndicators = []
        }
    }
}

#Preview {
    QuizView(topic: .greekGods)
}
