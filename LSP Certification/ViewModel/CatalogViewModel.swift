//
//  CatalogViewModel.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Supabase
import Foundation

@Observable
class CatalogViewModel {
    var books: [Book] = []

    // Func to load books from fetchbooks query
    func loadBooks() async {
        do {
            books = try await SupabaseService.shared.fetchBooks()
                .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }

            
            print("Total books loaded: \(books.count)")
        } catch {
            print(error)
        }
        
    }
    
    // Func to add loan from a user
    func addLoan(for book: Book, loanDate: Date) async throws {
        guard let user = SessionManager.shared.currentUser else {
            print("No user logged in to add loan")
            return
        }
        
        let returnDate = Calendar.current.date(byAdding: .day, value: 7, to: loanDate) ?? loanDate
        
        let loanData = Loan(
            id: UUID(),
            bookId: book.id,
            userId: user.id,
            loanDate: loanDate,
            returnDate: returnDate,
            actualReturnDate: nil
        )
        
        do {
            try await SupabaseService.shared.client
                .from("loans")
                .insert([loanData])
                .execute()
            
            
            try await SupabaseService.shared.client
                .from("books")
                .update([
                    "availability": "unavailable"
                ])
                .eq("id", value: book.id)
                .execute()
            
            
            
            await loadBooks()
            
            print("Loan added successfully")
        }
        catch {
            print("Failed to add loan, \(error)")
        }
        
    }
    
}
