//
//  ContentViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
        
//        let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
//        let url = urlApp!.appendingPathComponent("default.store")
//        if FileManager.default.fileExists(atPath: url.path) {
//            print("swiftdata db at \(url.absoluteString)")
//        }

    }
    
    
    func setupSubscribers() {
        
        service.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
