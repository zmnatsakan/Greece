//
//  ContentView.swift
//  Greece
//
//  Created by mnats on 27.12.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
//    @State var isFirstLaunch = true
    @State var topic: Topic = .greekGods
    @State var isPickerPresented = false
    
    @ViewBuilder func pickerView() -> some View {
        if isPickerPresented {
            VStack {
                ForEach(Topic.allCases, id: \.self) { topic in
                    NavigationLink(destination: QuizView(topic: topic)
                        .toolbar(.hidden, for: .navigationBar)) {
                            let score = UserDefaults.standard.integer(forKey: topic.rawValue)
                            HStack {
                                Text(topic.rawValue)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(1)
                                    .padding(.horizontal)
                                Spacer()
                                if score > 0 {
                                    let maxScore = Constants.questions.filter({$0.topic == topic}).count - 1
                                    Text("\(score) / \(maxScore)").padding(.horizontal)
                                        .foregroundStyle(score == maxScore ? .green : .white)
                                        .shadow(color: .gray, radius: 2)
                                        .padding(.horizontal)
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
    
    @ViewBuilder func mainView() -> some View {
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
                        .padding(.horizontal)
                }
                NavigationLink(destination: TreeView()
                    .toolbar(.hidden, for: .navigationBar)) {
                    Text("Persons")
                        .tint(.white)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .titleBack()
                        .padding(.horizontal)
                }
                NavigationLink(destination: FavoritesView()
                    .toolbar(.hidden, for: .navigationBar)) {
                    Text("Favorites")
                        .tint(.white)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .titleBack()
                        .padding(.horizontal)
                }
                NavigationLink(destination: SettingsView()
                    .toolbar(.hidden, for: .navigationBar)) {
                    Text("Settings")
                        .tint(.white)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity)
                        .titleBack()
                        .padding(.horizontal)
                }
            }
            .padding()
            .overlay {
                pickerView()
            }
            .onAppear {
                isPickerPresented = false
            }
            .background {
                Image("back")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            }
        }
    }
    
    var body: some View {
        if isFirstLaunch {
            TutorialView {
                isFirstLaunch = false
            }
        } else {
            mainView()
        }
    }
}

#Preview {
    ContentView()
}
