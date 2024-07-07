//
//  DataManager.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class DataManager: ObservableObject {
    static let shared = DataManager()
    var fetchedBooks: [FetchedBook] = []
    var cancellable: AnyCancellable?

    let persistantContainer: ModelContainer = {
        do {
            let schema = Schema([
                User.self,
                Book.self
            ])
            
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            
            return container
        } catch {
            fatalError("Failed to create Container")
        }
    }()

    private init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/data") else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [FetchedBook].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fetchedBooks in
                self?.fetchedBooks = fetchedBooks
                Task {
                    await self?.saveFetchedBooksToSwiftData(fetchedBooks: fetchedBooks)
                }
            })
    }
    
    func createUser(name: String, password: String, bio: String? = nil) async throws {
        let user = User(name: name, password: password, bio: bio)
        debugPrint("Insert User \(name) \(password)")
        persistantContainer.mainContext.insert(user)
        try persistantContainer.mainContext.save()
    }
    
    func addBook(for user: User, book: Book) async throws {
        user.savedBooks?.append(book)
        debugPrint("Add Book \(book.title) To \(user.name)")
        try persistantContainer.mainContext.save()
    }
    
    func getUserBooks(for user: User) async throws -> [Book]? {
        return user.savedBooks
    }
    
    func getAllUsers() async throws -> [User] {
        do {
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)]))
            return data
        } catch {
            debugPrint("Failed Fetch All Users")
            throw error
        }
    }
    
    func getUserByName(name: String) async throws -> User? {
        do {
            let predicate = #Predicate<User> { user in
                user.name == name
            }
            
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            let user = try persistantContainer.mainContext.fetch(descriptor)
            return user.first
        } catch {
            debugPrint("Failed Fetch User By Name")
            throw error
        }
    }
    
    func getAllBooks() async throws -> [Book] {
        do {
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<Book>(sortBy: [SortDescriptor(\.title)]))
            return data
        } catch {
            debugPrint("Failed Fetch All Books")
            throw error
        }
    }
    
    func getBooksByGenre(genre: String) async throws -> [Book] {
        do {
            let predicate = #Predicate<Book> { book in
                book.genres.contains(genre)
            }
            
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 4
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<Book>(sortBy: [SortDescriptor(\.title)]))
            return data
        } catch {
            debugPrint("Failed Fetch All Books")
            throw error
        }
    }
    
    func saveFetchedBooksToSwiftData(fetchedBooks: [FetchedBook]) async {
        fetchedBooks.forEach { fetchedBook in
            let newBook = Book(
                title: fetchedBook.title,
                author: fetchedBook.author,
                country: fetchedBook.country,
                imageLink: fetchedBook.imageLink,
                language: fetchedBook.language,
                link: fetchedBook.link,
                pages: fetchedBook.pages,
                descriptions: fetchedBook.descriptions,
                year: fetchedBook.year
            )
            persistantContainer.mainContext.insert(newBook)
        }
        do {
            try persistantContainer.mainContext.save()
        } catch {
            print("Failed to save books: \(error)")
        }
    }
}
