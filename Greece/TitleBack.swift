//
//  TitleBack.swift
//  Greece
//
//  Created by mnats on 15.01.2024.
//

import SwiftUI

struct TitleBack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0.3, blue: 0), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.58, blue: 0.18), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            )
            .cornerRadius(11)
    }
}

struct ElementBack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0.66, blue: 0), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.58, blue: 0.18), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            )
            .cornerRadius(11)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .inset(by: 0.5)
                    .stroke(Color(red: 1, green: 0.6, blue: 0), lineWidth: 1)
            )
    }
}

extension View {
    func titleBack() -> some View {
        self.modifier(TitleBack())
    }
    func elementBack() -> some View {
        self.modifier(ElementBack())
    }
}
