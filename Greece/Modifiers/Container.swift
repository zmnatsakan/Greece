//
//  Container.swift
//  Greece
//
//  Created by mnats on 18.01.2024.
//

import SwiftUI

struct Container: ViewModifier {
    @Environment(\.isInsideNavigationView) var isInsideNavigationView
    @Environment(\.dismiss) var dismiss
    let label: String?
    let isBack: Bool
    let customAction: () -> ()
    func body(content: Content) -> some View {
        VStack {
            if let label {
                Text(label)
                    .padding(.horizontal, 70)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .frame(maxWidth: .infinity)
                    .font(.title.bold())
                    .tint(.white)
                    .titleBack()
                    .zIndex(2)
                    .scaleEffect(1.02)
                    .overlay {
                        if isBack {
                            HStack {
                                Button {
                                    customAction()
                                    dismiss()
                                } label: {
                                    Image(systemName: isInsideNavigationView ? "arrow.left" : "xmark.circle")
                                        .font(.largeTitle.bold())
                                        .padding()
                                }
                                Spacer()
                            }
                        }
                    }
                    .offset(y: 40)
                    .padding(.top, -30)
            }
            content
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .background {
                    Rectangle()
                        .foregroundStyle(Color(red: 0.43, green: 0.18, blue: 0.4).opacity(0.84))
                        .cornerRadius(11)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 11)
                                .inset(by: 0.5)
                                .stroke(.white, lineWidth: 1)
                        )
                }
        }
        .padding(.horizontal)
        .foregroundStyle(.white)
    }
}

extension View {
    func container(label: String? = nil, isBack: Bool = false, customAction: @escaping () -> Void = {}) -> some View {
        self.modifier(Container(label: label, isBack: isBack, customAction: customAction))
    }
}
