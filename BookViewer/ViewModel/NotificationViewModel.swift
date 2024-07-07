//
//  NotificationViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI
import Combine

class NotificationViewModel: ObservableObject {
    static let shared = NotificationViewModel()
    
    @Published var notificationMessage: String = ""
    @Published var showNotification: Bool = false
    @Published var backgroundColor: Color = .blue

    private var timer: AnyCancellable?

    func showNotification(message: String, backgroundColor: Color = .blue) {
        self.notificationMessage = message
        self.backgroundColor = backgroundColor
        withAnimation {
            self.showNotification = true
        }

        timer?.cancel()
        timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect().sink { _ in
            withAnimation {
                self.showNotification = false
            }
            self.timer?.cancel()
        }
    }
}

