//
//  MyLoansViewModel.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Supabase
import Foundation

@Observable
class MyLoansViewModel {
    var loans: [Loan] = []
    
    // Func to load all loans from 1 user
    func loadLoansByUser(for userId : UUID) async {
        
        do {
            loans = try await SupabaseService.shared.fetchLoansByUser(for: userId)
            loans.sort { $0.actualReturnDate == nil && $1.actualReturnDate != nil }
            print("Loans loaded:", loans.count)
        } catch {
            print("Error fetching loans:", error)
        }
    }
    
    // Func to return a book from loan
    func returnLoan(_ loan: Loan) async throws {
        let today = Date()
        
        try await SupabaseService.shared.client
            .from("loans")
            .update([
                "actualReturnDate": ISO8601DateFormatter().string(from: today)
            ])
            .eq("id", value: loan.id)
            .execute()
        
        try await SupabaseService.shared.client
            .from("books")
            .update([
                "availability": "available"
            ])
            .eq("id", value: loan.bookId)
            .execute()
        
        guard let userId = SessionManager.shared.currentUser?.id else {
            print("No current user")
            return
        }
        await loadLoansByUser(for: userId)
    }
    
    
}
