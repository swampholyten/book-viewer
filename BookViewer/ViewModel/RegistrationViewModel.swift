//
//  RegistrationViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation

@MainActor
class RegistrationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var password = ""
    
    func createUser() async throws {
        
        try await AuthService.shared.createUser(name: name, password: password)

        
        name = ""
        password = ""
    }
}



