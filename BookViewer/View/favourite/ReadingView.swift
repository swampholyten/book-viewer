//
//  ReadingView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct ReadingView: View {
    
    var book: Book
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            
            // Main Content
            ScrollView {
                
                Text(book.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text(book.author)
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                
                VStack {
                    Text(book.descriptions)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .padding()
                }
                .background(RoundedRectangle(cornerRadius: 5).stroke())
                .padding()
                
                LazyVStack {
                    ForEach(1..<book.pages, id: \.self) { index in
                        Text("\(index)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("I was nine the first time the Physicians came in house. My uncle and his men were away My cousin Ione and her brothers played loudly in the kitchen, and my aunt did not hear the pounding at the door until the first man in white robes was already in the parlor. She did not have time to hide me. I was asleep, resting like a cat in the window.")
                            
                            Text("When she shook me awake, her voice was thick with fear. “Go to the wood,” she whispered, unlatching the window and gently pushing me through the casement to the ground below.")
                        }
                        .lineSpacing(8)
                        .padding()
                    }
                }

            }
            
//            HStack {
//                Text("20 mins left in Chapter")
//                    .font(.footnote)
//                Spacer()
//                Text("0%")
//                    .font(.footnote)
//            }
//            .padding()
        }
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
        .edgesIgnoringSafeArea(.all)
        .padding()
    }
}


//#Preview {
//    ReadingView()
//}
