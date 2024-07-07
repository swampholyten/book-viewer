//
//  NotificationNames.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import Foundation

extension Notification.Name {
    static let userLoggedIn = Notification.Name("userLoggedIn")
    static let userFailedLoggedIn = Notification.Name("userFailedLoggedIn")
    static let bookSaved = Notification.Name("bookSaved")
    static let bookRemoved = Notification.Name("bookRemoved")
    static let changesSaved = Notification.Name("changesSaved")
}
