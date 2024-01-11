//
//  PersonDetail.swift
//  Greece
//
//  Created by mnats on 28.12.2023.
//

struct PersonDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let gender: String
    let mother: Person?
    let father: Person?
    let spouse: [Person]?
    let son: [Person]?
    let daughter: [Person]?
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "personID"
        case name
        case gender
        case mother
        case father
        case spouse
        case son
        case daughter
        case description
    }
}

struct Person: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "personID"
        case name
    }
}
