//
//  PersonDetailsView.swift
//  Greece
//
//  Created by mnats on 29.12.2023.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.isInsideNavigationView) var isInsideNavigationView
    @Environment(\.dismiss) var dismiss
    var person: PersonDetail
    var viewModel: TreeViewModel
    @State private var isInFavorites = false
    
    @ViewBuilder func button(_ person: Person) -> some View {
        if isInsideNavigationView {
            NavigationLink(
                destination: PersonDetailView(person: viewModel.persons.first {$0.id == person.id}!,
                                              viewModel: viewModel)
            ) {
                Text(person.name)
                    .font(.title)
                    .bold()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    .elementBack()
                    .padding(.horizontal, 30)
            }
        } else {
            Text(person.name)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 20)
                .padding(.horizontal, 30)
        }
    }

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        Group {
                            if let image = UIImage(named: person.name) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 15))
                                    .padding()
                            } else {
                                Image(uiImage: UIImage(named: person.gender)!)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 15))
                                    .padding()
                            }
                            
                            Button {
                                if viewModel.favorites.contains(person.id){
                                    viewModel.favorites.removeAll(where: {$0 == person.id})
                                } else {
                                    viewModel.favorites.append(person.id)
                                }
                                isInFavorites.toggle()
                            } label: {
                                Image(systemName: isInFavorites ? "heart.fill" : "heart")
                                    .font(.system(size: 30).bold())
                                    .foregroundStyle(Color(red: 0.9, green: 0.2, blue: 0.2))
                                    .background {
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 30).bold())
                                            .foregroundStyle(Color(red: 0.8, green: 0.3, blue: 0.3).opacity(0.3))
                                    }
                            }
                            .padding(20)
                            .onAppear {
                                isInFavorites = viewModel.favorites.contains(person.id)
                            }
                        }
                    }
                    
                    
                    Text("Gender: \(person.gender == "male" ? "♂" : "♀")")
                    if !person.description.isEmpty {
                        Text(person.description)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .container(label: person.name, isBack: true)
            }
            
            if let mother = person.mother {
                button(mother)
                    .container(label: "Mother")
            }
            if let father = person.father {
                button(father)
                    .container(label: "Father")
            }
            if let spouses = person.spouse {
                VStack {
                    ForEach(spouses, id: \.id) { spouse in
                        button(spouse)
                    }
                }
                    .container(label: (person.gender == "male" ? "Wife" : "Husband") + (spouses.count > 1 ? "s" : ""))
            }
            if let sons = person.son {
                VStack {
                    ForEach(sons, id: \.id) { son in
                        button(son)
                    }
                }
                .container(label: "Son" + (sons.count > 1 ? "s" : ""))
            }
            if let daughters = person.daughter {
                VStack {
                    ForEach(daughters, id: \.id) { daughter in
                        button(daughter)
                    }
                }
                .container(label: "Daughter" + (daughters.count > 1 ? "s" : ""))
            }
            
        }
        .background {
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        }
        .toolbar(.hidden, for: .navigationBar)
        
        .foregroundStyle(.white)
    }
}

#Preview {
    var vm = TreeViewModel()
    return PersonDetailView(person: vm.persons.first!, viewModel: vm)
}
