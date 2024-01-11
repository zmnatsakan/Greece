//
//  TreeView.swift
//  Greece
//
//  Created by mnats on 28.12.2023.
//

import SwiftUI

struct TreeView: View {
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
        List(filteredPersons, id: \.id) { person in
            NavigationLink(destination: PersonDetailView(person: person, viewModel: viewModel)) {
                Text(person.name)
                    .font(.headline)
            }
        }
        .searchable(text: $searchText, prompt: "Search")
        .navigationTitle("Greek Mythology")
    }
}

#Preview {
    TreeView()
}
