//
//  LoanWithDetails.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Foundation

struct LoanWithDetails: Identifiable, Codable {
    let id: UUID
    let loanDate: Date
    let returnDate: Date
    let actualReturnDate: Date?
    let bookTitle: String
    let userName: String
    
    enum CodingKeys: String, CodingKey {
            case id
            case loanDate = "loan_date"
            case returnDate = "return_date"
            case actualReturnDate = "actual_return_date"
            case bookTitle = "book_title"
            case userName = "user_name"
        }
}
