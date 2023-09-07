//
//  Person.swift
//  AppNetwork
//
//  Created by Gabriel Mors  on 07/09/23.
//

import Foundation

struct PersonList {
    var person: [Person]
}

struct Person {
    var name: String
    var lastName: String
    var phone: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case lastName = "sobrenome"
        case phone = "telefone"
    }
}
