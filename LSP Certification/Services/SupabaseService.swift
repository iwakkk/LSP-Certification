//
//  SupabaseService.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 09/01/26.
//

import Supabase
import Foundation

final class SupabaseService {
    static let shared = SupabaseService()
    
    let client: SupabaseClient
    
    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://qhzxwdzodxwmrklgolxd.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFoenh3ZHpvZHh3bXJrbGdvbHhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NjMwODcsImV4cCI6MjA4MzUzOTA4N30.pCZrKixmG0XZUq4LlkmSMyZ9npom1gF49-Nhg4EMsmI"
        )
            
    }
}

extension SupabaseService {

    // Fetch all books from databse
    func fetchBooks() async throws -> [Book] {
        try await client
            .from("books")
            .select()
            .execute()
            .value
    }
    
    // Fetch user by inputted name
    func fetchUserByName(_ name: String) async throws -> User {
        try await client
            .from("users")
            .select()
            .eq("name", value: name)
            .single()
            .execute()
            .value
    }
    
    // Fetch all loans with details
    func fetchLoansWithDetails() async throws -> [LoanWithDetails] {
        try await client
            .from("loans_with_details")
            .select()
            .execute()
            .value
    }
    
    // Fetch loans by user
    func fetchLoansByUser(for userId: UUID) async throws -> [Loan] {
        try await client
            .from("loans")
            .select()
            .eq("userId", value: userId)
            .execute()
            .value
    }
    
}

