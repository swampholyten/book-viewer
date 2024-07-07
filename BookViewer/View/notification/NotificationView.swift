//
//  NotificationView.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI

struct NotificationView: View {
    let message: String
    let backgroundColor: Color
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(message)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(width: 256, height: 44)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black : Color.white)
            )
            .foregroundColor(colorScheme == .light ? .white : .black)
            .frame(maxWidth: .infinity)
            .padding()
    }
}


#Preview {
    NotificationView(message: "Book Removed", backgroundColor: .red)
}
