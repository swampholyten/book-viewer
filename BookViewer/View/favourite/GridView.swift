//
//  GridView.swift
//  BookViewer
//
//  Created by junkai ji on 07/07/24.
//

import SwiftUI

struct GridView: View {
    var favoriteBooks: [Book]
    var columns: [GridItem]
    @Binding var showEditButton: Bool
    var onDelete: (Book) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(favoriteBooks) { favoriteBook in
                    ZStack {
                        NavigationLink(value: favoriteBook) {
                            BookPoster(book: favoriteBook)
                        }
                        if showEditButton {
                            Button(action: {
                                onDelete(favoriteBook)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .padding(8)
                                    .opacity(0.8)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 24)
                            .padding(.trailing, 8)
                        }
                    }
                }
            }
        }
    }
}
