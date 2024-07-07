//
//  BookPoster.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI

struct BookPoster: View {
    let width = 100.0
    let height = 148.0
    
    var book: Book
    
    var body: some View {

        let placeholder = RoundedRectangle(cornerRadius: 8.0)
            .frame(width: self.width, height: self.height)
            .foregroundStyle(.gray)
        
        let imageBuilder: (Image) -> some View = { image in
            image
                .resizable()
                .frame(width: self.width, height: self.height)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
        
        VStack {
            if let uiImage = UIImage(named: book.imageLink) {
                imageBuilder(Image(uiImage: uiImage))
            } else {
                placeholder
            }
            
            Text(book.title)
                .font(.caption)
                .padding(.top, 2)
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: self.width)
        }
        .padding(.bottom, 16)
    }
}
