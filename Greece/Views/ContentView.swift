//
//  ContentView.swift
//  Greece
//
//  Created by mnats on 27.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State var topic: Topic = .greekGods
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: QuizView(topic: topic)) {
                        Text("Quiz")
                            .frame(maxWidth: .infinity)
                            .font(.largeTitle.bold())
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundStyle(.blue)
                                    .opacity(0.3)
                            }
                            .tint(.white)
                        
                    }
                    
                    Spacer()
                    
                    Picker(selection: $topic, label: Text("Topic")) {
                        ForEach(Topic.allCases, id: \.self) { topic in
                            Text(topic.rawValue)
                        }
                    }
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
