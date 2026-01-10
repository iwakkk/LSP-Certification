//
//  SessionManager.swift
//  LSP Certification
//
//  Created by Edward Suwandi on 10/01/26.
//

import Foundation

@Observable
class SessionManager {
    static let shared = SessionManager()
    
    var currentUser: User?
    
}
