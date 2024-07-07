//
//  BookImageCarouselView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct BookImageCarouselView: View {
    let book: Book
    
    var body: some View {
        TabView {
            ForEach([book.imageLink], id: \.self) {
                image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

