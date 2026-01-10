//
//  Book.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import Foundation

struct Book: Codable, Identifiable {
    let id: UUID
    let title: String
    let author: String
    let availability: String
}

