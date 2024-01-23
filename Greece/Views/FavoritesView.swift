//
//  FavoritesView.swift
//  Greece
//
//  Created by mnats on 23.01.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = TreeViewModel()
    
    var favoritePersons: [PersonDetail] {
        return viewModel.persons.filter { viewModel.favorites.contains($0.id) }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(favoritePersons, id: \.id) { person in
                    NavigationLink(destination: PersonDetailView(person: person, viewModel: viewModel).environment(\.isInsideNavigationView, false)) {
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
        .container(label: "Favorites", isBack: true)
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
    FavoritesView()
}
