//
//  AdminDashboardViewModel.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Foundation
import Supabase

@Observable
class AdminDashboardViewModel {
    
    var loansWithDetails: [LoanWithDetails] = []

    // Func to load all loans with the details
    func loadLoansWithDetails() async {
        do {
            let loans = try await SupabaseService.shared.fetchLoansWithDetails()
            
            // Filter to keep the returned books under the unreturned
            loansWithDetails = loans.sorted {
                ($0.actualReturnDate == nil) && ($1.actualReturnDate != nil)
            }
            print("Total Loans: \(loansWithDetails.count)")
        }
        catch {
            print("Error fetching all loans: ", error)
        }
    }
}
