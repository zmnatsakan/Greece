//
//  PersonDetail.swift
//  Greece
//
//  Created by mnats on 28.12.2023.
//

struct PersonDetail: Codable {
    let personID: Int
    let name: String
    let gender: String
    let mother: Person?
    let father: Person?
    let spouse: [Person]?
    let son: [Person]?
    let daughter: [Person]?
    let description: String
}

struct Person: Codable {
    let personID: Int
    let name: String
}
