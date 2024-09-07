//
//  ExploreView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var showFilterSearchView = false
    @StateObject var viewModel = ExploreViewModel()

    var body: some View {
        NavigationStack {
            
            if (showFilterSearchView) {
                FilterSearchView(show: $showFilterSearchView, viewModel: viewModel)
            } else {
                ScrollView {
                    
                    SearchBar(viewModel: viewModel)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                showFilterSearchView.toggle()
                            }
                        }
                    
                    LazyVStack(spacing: 32) {
                        if viewModel.books.isEmpty {
                            Text("No books available")
                        } else {
                            ForEach(viewModel.books) { book in
                                NavigationLink(value: book) {
                                    BookItemView(book: book)
                                        .frame(height: 400)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationDestination(for: Book.self) { book in
                    BookDetailView(viewModel: viewModel, book: book)
                }
            }
        }
    }
}
