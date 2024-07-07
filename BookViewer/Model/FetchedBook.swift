//
//  FetchedBook.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation

struct FetchedBook: Codable {
    var title: String
    var author: String
    var country: String
    var imageLink: String
    var language: String
    var link: String
    var pages: Int
    var descriptions: String
    var year: Int
}
