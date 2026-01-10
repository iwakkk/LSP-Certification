//
//  ContentViewModel.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Foundation
import Supabase

@Observable
class ContentViewModel {
    
    var name = ""
    var showMember = false
    var showAdmin = false
    var errorMessage: String?
    
    func login() {
        guard !name.isEmpty else {
            errorMessage = "Please fill your name"
            return
        }
        
        Task {
            do {
                let user = try await SupabaseService.shared.fetchUserByName(name)
                
                SessionManager.shared.currentUser = user
                
                switch user.role {
                    
                case .admin:
                    showAdmin = true
                    
                case .member:
                    showMember = true
                    
                }
            } catch {
                errorMessage = "Failed to login, please enter a valid name"
            }
        }
    }
    
    func logout() {
        SessionManager.shared.currentUser = nil
        name = ""
        showMember = false
        showAdmin = false
    }
}
