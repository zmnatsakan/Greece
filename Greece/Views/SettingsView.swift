//
//  SettingsView.swift
//  Greece
//
//  Created by mnats on 18.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isRateUsPresented = false
    @State private var isTermsOfUsePresented = false
    @State private var isPrivacyPolicyPresented = false
    
    var body: some View {
        VStack {
            Button {
                isRateUsPresented.toggle()
            } label: {
                Text("Rate us")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .elementBack()
            }
            .padding(.horizontal)
            Button {
                isTermsOfUsePresented.toggle()
            } label: {
                Text("Terms of use")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .elementBack()
            }
            .padding(.horizontal)
            Button {
                isPrivacyPolicyPresented.toggle()
            } label: {
                Text("Privacy policy")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity)
                    .elementBack()
            }
            .padding(.horizontal)
        }
        .container(label: "Settings", isBack: true)
        .sheet(isPresented: $isRateUsPresented) {
            RateUsView()
                .modifier(CustomSheet(isPresented: $isRateUsPresented))
        }
        .sheet(isPresented: $isTermsOfUsePresented) {
            TermsOfUseView()
                .modifier(CustomSheet(isPresented: $isTermsOfUsePresented))
        }
        .sheet(isPresented: $isPrivacyPolicyPresented) {
            PrivacyPolicyView()
                .modifier(CustomSheet(isPresented: $isPrivacyPolicyPresented))
        }
        .background {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        }
    }
}

struct CustomSheet: ViewModifier {
    @State private var sheetHeight: CGFloat = .zero
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content
            .environment(\.isInsideNavigationView, false)
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                sheetHeight = newHeight
            }
            .presentationDetents([.height(sheetHeight + 20)])
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    SettingsView()
}
