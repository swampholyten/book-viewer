//
//  User.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation
import SwiftData

@Model
class User: ObservableObject {
    @Attribute(.unique) var name: String
    var password: String
    var bio: String?
    var latitude: Double?
    var longitude: Double?
    @Relationship var savedBooks: [Book]? = []

    
    init(name: String, password: String, bio: String? = nil, latitude: Double? = 37.7749, longitude: Double? = -122.4194) {
        self.name = name
        self.password = password
        self.bio = bio
        self.latitude = latitude
        self.longitude = longitude
    }
}
