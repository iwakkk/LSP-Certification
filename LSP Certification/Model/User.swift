//
//  User.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import Foundation

enum UserRole: String, Codable {
    case admin
    case member
}

struct User: Identifiable, Codable {
    let id : UUID
    let name : String
    let role : UserRole
}
