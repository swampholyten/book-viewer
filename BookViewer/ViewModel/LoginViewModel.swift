//
//  LoginViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(name: name, password: password)
    }
}
