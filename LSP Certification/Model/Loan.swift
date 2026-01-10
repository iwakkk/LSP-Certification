//
//  Loan.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import Foundation

// Loan struct
struct Loan : Identifiable, Codable {
    let id: UUID
    let bookId: UUID
    let userId: UUID
    let loanDate: Date
    let returnDate: Date
    let actualReturnDate: Date?
}
