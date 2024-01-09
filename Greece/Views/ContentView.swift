//
//  ContentView.swift
//  Greece
//
//  Created by mnats on 27.12.2023.
//

import SwiftUI

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
