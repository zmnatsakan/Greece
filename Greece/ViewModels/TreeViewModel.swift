//
//  TreeViewModel.swift
//  Greece
//
//  Created by mnats on 29.12.2023.
//

import Foundation
import Combine

final class TreeViewModel: ObservableObject {
    @Published var persons: [PersonDetail] = []
    
    init() {
        loadPersons()
    }
    
    func loadPersons() {
        if let url = Bundle.main.url(forResource: "persons", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.persons = try decoder.decode([PersonDetail].self, from: data)
                
                print(persons) // For debugging purposes
            } catch {
                print("Error loading or parsing JSON: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }
}
