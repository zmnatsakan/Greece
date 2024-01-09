//
//  PersonDetailsView.swift
//  Greece
//
//  Created by mnats on 29.12.2023.
//

import SwiftUI

struct PersonDetailView: View {
    var person: PersonDetail
    var viewModel: TreeViewModel

    var body: some View {
        List {
            if let image = UIImage(named: person.name) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Text("Gender: \(person.gender == "male" ? "♂" : "♀")")
            if !person.description.isEmpty {
                Text(person.description)
            }
            if let mother = person.mother {
                Section("Mother") {
                    NavigationLink(mother.name, destination: PersonDetailView(person: viewModel.persons.first {$0.personID == mother.personID}!, viewModel: viewModel))
                }
            }
            if let father = person.father {
                Section("Father") {
                    NavigationLink(father.name, destination: PersonDetailView(person: viewModel.persons.first {$0.personID == father.personID}!, viewModel: viewModel))
                }
            }
            if let spouses = person.spouse {
                Section((person.gender == "male" ? "Wife" : "Husband") + (spouses.count > 1 ? "s" : "")) {
                    ForEach(spouses, id: \.personID) { spouse in
                        NavigationLink(spouse.name, destination: PersonDetailView(person: viewModel.persons.first {$0.personID == spouse.personID}!, viewModel: viewModel))
                    }
                }
            }
            if let sons = person.son {
                Section("Son" + (sons.count > 1 ? "s" : "")) {
                    ForEach(sons, id: \.personID) { son in
                        NavigationLink(son.name, destination: PersonDetailView(person: viewModel.persons.first {$0.personID == son.personID}!, viewModel: viewModel))
                    }
                }
            }
            if let daughters = person.daughter {
                Section("Daughter" + (daughters.count > 1 ? "s" : "")) {
                    ForEach(daughters, id: \.personID) { daughter in
                        NavigationLink(destination: PersonDetailView(person: viewModel.persons.first { $0.personID == daughter.personID }!, viewModel: viewModel)) {
                            Text(daughter.name)
                        }
                    }
                }
            }
            
        }
        .navigationTitle(person.name)
    }
}
