//
//  BookItemView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct BookItemView: View {
    
    let book: Book

    
    var body: some View {
        VStack(spacing: 8) {
//            Images
            Image(book.imageLink)
                .resizable()
                .scaledToFit()
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            
//            Listing Details
            HStack(alignment: .top) {
//                details
                VStack(alignment: .leading) {
                    Text("\(book.title), \(book.author)")
                        .fontWeight(.semibold)
                    
                    Text("\(book.language)")
                        .foregroundStyle(.gray)
                    
                    Text("\(formatDate(book.date))")
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 4) {
                        Text("\(String(book.pages))")
                            .fontWeight(.semibold)
                        Text("pages")
                    }
                }
                
                Spacer()
                
//                rating
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                    
                    Text("\(book.rating, specifier: "%.1f")")
                }
            }
            .font(.footnote)
        }
        .padding()
    }
    
        
        // Function to format date to "d MMM yyyy" format
        func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            return dateFormatter.string(from: date)
        }
}

