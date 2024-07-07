//
//  BookDetailView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: User
    @ObservedObject var viewModel: ExploreViewModel
    
    var book: Book


    
    var body: some View {
        
        let readingTime = calculateReadingTime(pages: book.pages)
        
        ScrollView {
            
            ZStack(alignment: .topLeading) {
                
                BookImageCarouselView(book: book)
                    .frame(height: 320)
                
                // Remove the custom dismiss button
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        
                        Image(systemName: "star.fill")
                        
                        Text("\(book.rating, specifier: "%.1f")")
                        
                        Text(" - ")
                        
                        Text("\(String(book.pages)) pages")
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 4)
                    
                    Text("\(book.language), \(book.country)")
                }
                .font(.caption)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            VStack(alignment: .leading,spacing: 4) {
                Text(book.descriptions)
                    .font(.footnote)
            }
            .padding()
            
            Divider()
            
            //            Host info view
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("This book is written by")
                        .font(.footnote)
                    Text(book.author)
                        .font(.headline)
                        .frame(width: 250, alignment: .leading)
                }
                .frame(width: 300, alignment: .leading)
                
                Spacer()
                
                Image(book.imageLink)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }
            .padding()
            
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("This book's genre/s")
                    .font(.headline)
                
                ForEach(book.genres, id: \.self) { genre in
                    HStack {
                        Image(systemName: "book")
                            .frame(width: 24)
                        
                        Text(genre)
                            .font(.footnote)
                        
                        Spacer()
                    }
                }
            }
            .padding()
            
            Divider()
            
            //            Bedrooms view
            VStack(alignment: .leading) {
                Text("You might be also interested in")
                    .font(.headline)
                
                BookCarouselView(genre: book.genres.first!, viewModel: viewModel)
            }
            .padding()
            
        }
//        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Back")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                })
                
            }
        }
        .ignoresSafeArea()
        .padding(.bottom, 64)
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("You need approximately")
                            .font(.footnote)
                        
                        Text("\(readingTime.hours) hours and \(readingTime.minutes) minutes")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .underline()
                        
                        Text(" to read this book.")
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        toggleBookFromList()
                    }, label: {
                        Text(isBookSaved() ? "Remove" : "Save")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140, height: 40)
                            .background(isBookSaved() ? .mint : .pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    })
                }
                .padding(.horizontal, 32)
            }
            .padding(.vertical, 4)
        }
    }
    
    func toggleBookFromList() {
        if let index = user.savedBooks?.firstIndex(where: { $0.id == book.id }) {
            user.savedBooks?.remove(at: index)
            NotificationCenter.default.post(name: .bookRemoved, object: nil)
        } else {
            user.savedBooks?.append(book)
            NotificationCenter.default.post(name: .bookSaved, object: nil)
        }
        debugPrint("Toggled book in list")
    }
    
    func isBookSaved() -> Bool {
        return user.savedBooks!.contains(where: { $0.id == book.id })
    }
    
    private func calculateReadingTime(pages: Int) -> (hours: Int, minutes: Int) {
        // Assuming an average reading speed of 30 pages per hour
        let pagesPerHour = 30
        let totalHours = pages / pagesPerHour
        let remainingPages = pages % pagesPerHour
        let minutes = remainingPages * 60 / pagesPerHour
        
        return (hours: totalHours, minutes: minutes)
    }
}
