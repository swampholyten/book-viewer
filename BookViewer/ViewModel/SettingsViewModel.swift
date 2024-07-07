//
//  SettingsViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI
import LocalAuthentication

class SettingsViewModel: ObservableObject {
    @AppStorage("appearanceMode") var appearanceMode: AppearanceMode = .system
    @AppStorage("useBiometrics") var useBiometrics: Bool = false

    enum AppearanceMode: String, CaseIterable, Identifiable {
        case light = "Light"
        case dark = "Dark"
        case system = "System"
        
        var id: String { self.rawValue }
    }
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to enable biometrics."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            completion(false)
        }
    }
}
