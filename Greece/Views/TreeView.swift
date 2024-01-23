//
//  TreeView.swift
//  Greece
//
//  Created by mnats on 28.12.2023.
//

import SwiftUI

struct IsInsideNavigationViewKey: EnvironmentKey {
    static let defaultValue = true
}

extension EnvironmentValues {
    var isInsideNavigationView: Bool {
        get { self[IsInsideNavigationViewKey.self] }
        set { self[IsInsideNavigationViewKey.self] = newValue }
    }
}

struct TreeView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = TreeViewModel()
    @State private var searchText = ""
    
    var filteredPersons: [PersonDetail] {
        if searchText.isEmpty {
            return viewModel.persons
        } else {
            return viewModel.persons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            TextField(text: $searchText) {
                Text("Search...")
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding()
            .font(.title.bold())
            ScrollView {
                ForEach(filteredPersons, id: \.id) { person in
                    NavigationLink(destination: PersonDetailView(person: person, viewModel: viewModel)) {
                        Text(person.name)
                            .font(.title)
                            .bold()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .elementBack()
                            .padding(.horizontal, 30)
                    }
                }
            }
        }
        .container(label: "Persons", isBack: true)
        .background {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    NavigationView {
        TreeView()
    }
}
