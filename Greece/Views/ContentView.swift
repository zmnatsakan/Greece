//
//  ContentView.swift
//  Greece
//
//  Created by mnats on 27.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State var topic: Topic = .greekGods
    @State var isPickerPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button {
                    isPickerPresented = true
                } label: {
                    Text("Quiz")
                        .tint(.white)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .titleBack()
                        .padding()
                }
                NavigationLink(destination: TreeView()
                    .toolbar(.hidden, for: .navigationBar)) {
                    Text("Persons")
                        .tint(.white)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .titleBack()
                        .padding()
                }
            }
            .padding()
            .overlay {
                if isPickerPresented {
                    VStack {
                        ForEach(Topic.allCases, id: \.self) { topic in
                            NavigationLink(destination: QuizView(topic: topic)
                                .toolbar(.hidden, for: .navigationBar)) {
                                    let score = UserDefaults.standard.integer(forKey: topic.rawValue)
                                    HStack {
                                        if score > 0 {
                                            Spacer()
                                        }
                                        Text(topic.rawValue)
                                            .minimumScaleFactor(0.1)
                                            .lineLimit(2)
                                        if score > 0 {
                                            Spacer()
                                            Text("\(score) / \(Constants.questions.filter({$0.topic == topic}).count - 1)").padding(.horizontal)
                                        }
                                    }
                                    .tint(.white)
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity)
                                    .elementBack()
                                    .padding(.horizontal)
                                }
                        }
                    }
                    .container(label: "Pick theme", isBack: true, customAction: {isPickerPresented.toggle()})
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isPickerPresented = false
                            }
                    }
                    .foregroundStyle(.white)
                }
            }
            .onAppear {
                isPickerPresented = false
            }
        }
    }
}

#Preview {
    ContentView()
}
