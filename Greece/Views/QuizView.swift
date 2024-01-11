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
    
    var body: some View {
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
                }
                
                Spacer()
                
                Text(viewModel.currentQuestion.text)
                    .font(.headline)
                    .frame(height: 100)
                
                VStack {
                    ForEach(viewModel.currentQuestion.options, id: \.self) { option in
                        HStack {
                            Button {
                                if selectedOption == nil {
                                    selectedOption = option
                                    withAnimation {
                                        questionIndicators[viewModel.currentQuestionNumber] =  viewModel.checkAnswer(option)
                                    }
                                }
                            } label: {
                                Text(option)
                                    .tint(.primary)
                                    .frame(maxWidth: .infinity)
                                    .bold()
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundStyle(
                                                selectedOption == option ? (viewModel.checkAnswer(option) ? Color.green : Color.red) : .gray
                                            )
                                            .opacity(0.3)
                                    }
                            }
                            .disabled(selectedOption != nil)
                            
                            if let person = treeViewModel.persons.first(where: { $0.name == option }), selectedOption != nil {
                                Button {
                                    selectedPerson = person
                                } label: {
                                    Text("i")
                                        .tint(.primary)
                                        .bold()
                                        .padding()
                                        .background {
                                            RoundedRectangle(cornerRadius: 25)
                                                .foregroundStyle(.gray)
                                                .opacity(0.3)
                                                .aspectRatio(1, contentMode: .fit)
                                        }
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
            } else {
                Text("Your result is \(questionIndicators.reduce(0) { $0 + ($1 == true ? 1 : 0) }) / \(questionIndicators.count)")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(.blue)
                            .opacity(0.3)
                    }
                    .tint(.white)
                
                Button {
                    dismiss()
                    viewModel.isFinished = false
                } label: {
                    Text("Finish")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.blue)
                                .opacity(0.3)
                        }
                        .tint(.white)
                }
                
                
            }
            
            Spacer()
            
        }
        .padding()
        .sheet(item: $selectedPerson) { person in
            VStack {
                ZStack {
                    HStack {
                        Button("Hide") {
                            selectedPerson = nil
                        }
                        Spacer()
                    }
                    Text(person.name)
                        .font(.largeTitle.bold())
                }
                .padding()
                PersonDetailView(person: person, viewModel: treeViewModel)
            }
        }
    }
}

#Preview {
    QuizView(topic: .greekGods)
}
