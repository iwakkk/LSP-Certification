//
//  LSP_CertificationTests.swift
//  LSP CertificationTests
//
//  Created by Edward Suwandi on 09/01/26.
//

import Testing
@testable import LSP_Certification
import Foundation

struct LSP_CertificationTests {

    var catalogViewModel = CatalogViewModel()
    var myLoansViewModel = MyLoansViewModel()
    var adminDashboardViewModel = AdminDashboardViewModel()
    var contentViewModel = ContentViewModel()

    @Test
    func testLoadBooks() async throws {
        await catalogViewModel.loadBooks()
        #expect(!catalogViewModel.books.isEmpty, "Books should be loaded from Supabase")
    }
    
    @Test
    func testLoadLoans() async throws {
        guard let userId = UUID(uuidString: "8e593c14-638a-4de3-abb7-39b25b38166b") else {
            #expect(false, "Invalid UUID")
            return
        }

        await myLoansViewModel.loadLoansByUser(for: userId)
        #expect(!myLoansViewModel.loans.isEmpty, "Loans should be loaded")
    }
    
    @Test
    func testLoadAllLoans() async throws {
        await adminDashboardViewModel.loadLoansWithDetails()
        #expect(!adminDashboardViewModel.loansWithDetails.isEmpty, "Loans should be loaded from Supabase")
    }
    
    @Test
    func testAddLoan() async throws {
        
        // Set current user
           guard let userId = UUID(uuidString: "8e593c14-638a-4de3-abb7-39b25b38166b") else {
               #expect(false, "Invalid UUID")
               return
           }
        
        SessionManager.shared.currentUser = User(
            id: userId,
            name: "Member1",
            role: .member
        )
        
        // Load all books
        await catalogViewModel.loadBooks()
            #expect(!catalogViewModel.books.isEmpty, "Books should be loaded from Supabase")
        
        // Set book
        guard let book = catalogViewModel.books.first(where: { $0.availability == "available" }) else {
            #expect(false, "No available book")
            return
        }
        
        // Test to add Loan
        try await catalogViewModel.addLoan(for: book, loanDate: Date())
        
        
        let myLoansVM = MyLoansViewModel()
           await myLoansVM.loadLoansByUser(for: userId)
        
        let hasLoan = myLoansVM.loans.contains { $0.bookId == book.id }
            #expect(hasLoan, "Loan should be created")
        
        await catalogViewModel.loadBooks()
          let updatedBook = catalogViewModel.books.first { $0.id == book.id }
          #expect(updatedBook?.availability == "unavailable")
        
    }
    
    
    @Test
    func testLoginAsMember() async throws {
        
        contentViewModel.name = "Member1"
        
        contentViewModel.login()
        
        // Tunggu Task selesai
        try await Task.sleep(nanoseconds: 1_000_000_000)

        let user = SessionManager.shared.currentUser
        
        #expect(user != nil)
        #expect(user?.name == "Member1")
        
        if user?.role == .member {
            #expect(contentViewModel.showMember == true)
            #expect(contentViewModel.showAdmin == false)
        }
    }
    

}
