//
//  Book.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import Foundation
import SwiftData

@Model
class Book {
    @Attribute(.unique) var title: String
    
    var author: String
    var country: String
    var imageLink: String
    var language: String
    var link: String
    var pages: Int
    var descriptions: String
    var year: Int
    
    var rating: Double
    var date: Date
    var genres: [String]
    
    init(title: String, author: String, country: String, imageLink: String, language: String, link: String, pages: Int, descriptions: String, year: Int) {
        self.title = title
        self.author = author
        self.country = country
        self.imageLink = imageLink
        self.language = language
        self.link = link
        self.pages = pages
        self.descriptions = descriptions
        self.year = year
        self.rating = randomBetweenThreeAndFive()
        self.date = randomDate()
        self.genres = randomGenres()
    }
}

func randomGenres() -> [String] {
    let genres = ["Fantasy", "Science Fiction", "Mystery", "Thriller", "Romance", "Historical Fiction", "Horror", "Adventure", "Young Adult", "Literary Fiction"]
    
    // Generate random number of genres between 1 and 3
    let numberOfGenres = Int.random(in: 1...3)
    
    // Shuffle genres array
    let shuffledGenres = genres.shuffled()
    
    // Select random genres
    let selectedGenres = Array(shuffledGenres.prefix(numberOfGenres))
    
    return selectedGenres
}

func randomBetweenThreeAndFive() -> Double {
    let randomNumber = Double.random(in: 3.0..<5.0)
    return randomNumber
}

func randomDate() -> Date {
        // Define a range of possible dates (adjust as needed)
        let startDate = DateComponents(calendar: .current, year: 1024, month: 1, day: 1).date!
        let endDate = DateComponents(calendar: .current, year: 2012, month: 12, day: 31).date!
        
        // Generate a random time interval between start and end date
        let randomTimeInterval = TimeInterval.random(in: startDate.timeIntervalSince1970...endDate.timeIntervalSince1970)
        
        // Create and return a Date object from the random time interval
        return Date(timeIntervalSince1970: randomTimeInterval)
    }
