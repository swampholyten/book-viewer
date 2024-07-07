//
//  FavouriteView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        if let savedBooks = user.savedBooks, !savedBooks.isEmpty {
            BookGridView(favoriteBooks: savedBooks)
        } else {
            EmptyBookView()
        }
    }
}
