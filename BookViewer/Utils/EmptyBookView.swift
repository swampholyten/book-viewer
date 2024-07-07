//
//  EmptyBookView().swift
//  BookViewer
//
//  Created by junkai ji on 07/07/24.
//

import SwiftUI

struct EmptyBookView: View {
    var body: some View {
        
        
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.largeTitle)
                .foregroundStyle(.gray)
            
            Text("NO BOOKS ADDED YET")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        
    }
}

#Preview {
    EmptyBookView()
}
