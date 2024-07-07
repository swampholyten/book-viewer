//
//  ExploreViewModel.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    
    @Published var books = [Book]()
    @Published var selectedCountry = ""
    @Published var selectedLanguage = ""
    @Published var searchText = ""
    
    
    private var bookCopies = [Book]()
    
    init() {
        Task { try await fetchBooks() }
    }
    
    @MainActor
    func fetchBooks() async throws {
        do {
            self.books = try await DataManager.shared.getAllBooks()
            self.bookCopies = books
        }
    }
    
    func getRecommendedBooks(genre: String) -> [Book] {
        return books.filter({
            $0.genres.contains(genre)
        })
    }
    

    @MainActor
    func updateBooks() {
        let filteredBooks = bookCopies.filter { book in
            let matchesCountry = selectedCountry.isEmpty || book.country.lowercased() == selectedCountry.lowercased()
            let matchesLanguage = selectedLanguage.isEmpty || book.language.lowercased() == selectedLanguage.lowercased()
            let matchesTitle = searchText.isEmpty || book.title.lowercased().contains(searchText.lowercased())
            
            return matchesCountry && matchesLanguage && matchesTitle
        }

        self.books = filteredBooks.isEmpty ? bookCopies : filteredBooks
    }
}

