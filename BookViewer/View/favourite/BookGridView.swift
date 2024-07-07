//
//  BookGridView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct BookGridView: View {
    var favoriteBooks: [Book]
    
    @State private var showDeleteConfirmation = false
    @State private var bookToDelete: Book?
    @State private var showEditButton = false
    @EnvironmentObject var user: User

    @State private var sortAsc = true
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Text("Favorite Books")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.bottom, 40)
                
                GridView(favoriteBooks: favoriteBooks, columns: columns, showEditButton: $showEditButton, onDelete: { book in
                    showDeleteConfirmation = true
                    bookToDelete = book
                })
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this book?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let book = bookToDelete {
                                toggleBookFromList(book: book)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            .navigationDestination(for: Book.self) { favoriteBook in
                ReadingView(book: favoriteBook)
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showEditButton.toggle()
                    }, label: {
                        Text(showEditButton ? "Done" : "Edit")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    })
                }
            }
        }
    }
    
    func toggleBookFromList(book: Book) {
        if let index = user.savedBooks?.firstIndex(where: { $0.id == book.id }) {
            user.savedBooks?.remove(at: index)
            NotificationCenter.default.post(name: .bookRemoved, object: nil)
        } else {
            user.savedBooks?.append(book)
            NotificationCenter.default.post(name: .bookSaved, object: nil)
        }
        
        debugPrint("Toggled book in list")
    }
}
