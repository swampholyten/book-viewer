//
//  AuthService.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation
import SwiftData
import Combine

class AuthService: ObservableObject {
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    private init() {
        // Optionally load user data on initialization if required
    }
    
    @MainActor
    func login(name: String, password: String) async throws {
        guard let user = try await DataManager.shared.getUserByName(name: name),
              user.password == password else {
            NotificationCenter.default.post(name: .userFailedLoggedIn, object: nil)
            throw AuthError.invalidCredentials
        }
        DispatchQueue.main.async {
            self.currentUser = user
        }
        
        NotificationCenter.default.post(name: .userLoggedIn, object: nil)
    }
    
    @MainActor
    func createUser(name: String, password: String, bio: String? = nil) async throws {
        try await DataManager.shared.createUser(name: name, password: password, bio: bio)
        try await self.login(name: name, password: password)
    }
    
    func logout() {
        DispatchQueue.main.async {
            self.currentUser = nil
        }
    }
    
    enum AuthError: Error {
        case invalidCredentials
        case userNotFound
        case userAlreadyExists
    }
}
