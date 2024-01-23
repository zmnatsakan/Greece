//
//  AnswerButton.swift
//  Greece
//
//  Created by mnats on 16.01.2024.
//

import SwiftUI

struct AnswerButton: ViewModifier {
    enum AnswerType {
        case correct
        case incorrect
        case notSelected
        
        func gradient() -> LinearGradient {
            switch self {
            case .correct:
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.02, green: 1, blue: 0), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.97, blue: 0.18), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            case .incorrect:
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0, blue: 0), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.43, blue: 0.18), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            case .notSelected:
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0.66, blue: 0), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.58, blue: 0.18), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            }
        }
    }
    var answerType: AnswerType = .notSelected
    
    func body(content: Content) -> some View {
        content
            .shadow(radius: 3)
            .font(.title.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(
                answerType.gradient()
            )
            .cornerRadius(11)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.81, green: 0.73, blue: 0.59), lineWidth: 1)
            )
    }
}

extension View {
    func answerButton(answerType: AnswerButton.AnswerType = .notSelected) -> some View {
        self.modifier(AnswerButton(answerType: answerType))
    }
}
