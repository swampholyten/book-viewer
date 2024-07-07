//
//  BookCarouselView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct BookCarouselView: View {
    
    var genre: String
    @ObservedObject var viewModel: ExploreViewModel

    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.getRecommendedBooks(genre: genre) , id: \.id) { book in
                        NavigationLink(destination: BookDetailView(viewModel: viewModel, book: book)) {
                            VStack {
                                Image(book.imageLink)
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                
                                Text(book.title)
                                    .font(.caption)
                            }
                            .frame(width: 132, height: 200)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
}

