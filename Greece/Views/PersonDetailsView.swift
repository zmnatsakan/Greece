//
//  PersonDetailsView.swift
//  Greece
//
//  Created by mnats on 29.12.2023.
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
                                    Image(systemName: isInsideNavigationView ? "arrow.left" : "arrow.down")
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
    }
}

extension View {
    func container(label: String? = nil, isBack: Bool = false, customAction: @escaping () -> Void = {}) -> some View {
        self.modifier(Container(label: label, isBack: isBack, customAction: customAction))
    }
}

struct PersonDetailView: View {
    @Environment(\.isInsideNavigationView) var isInsideNavigationView
    @Environment(\.dismiss) var dismiss
    var person: PersonDetail
    var viewModel: TreeViewModel
    
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
                    if let image = UIImage(named: person.name) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 15))
                            .padding()
                    }
                    Text("Gender: \(person.gender == "male" ? "♂" : "♀")")
                    if !person.description.isEmpty {
                        Text(person.description)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .container(label: person.name, isBack: true)
//
//                
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: isInsideNavigationView ? "arrow.left" : "arrow.down")
//                            .font(.title.bold())
//                            .foregroundStyle(.white)
//                    }
//                    .padding(24)
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
