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
    
    func loadLoansByUser() async {
        guard let user = SessionManager.shared.currentUser else {
            print("No user logged in to load MyLoans")
            
            
            return
        }
        
        do {
            loans = try await SupabaseService.shared.fetchLoansByUser(for: user.id)
            
            print("Loans loaded:", loans.count)
        } catch {
            print("Error fetching loans:", error)
        }
    }
    
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
        
        await loadLoansByUser()
    }
    
    
}
