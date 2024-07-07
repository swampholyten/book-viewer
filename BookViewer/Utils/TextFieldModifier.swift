//
//  TextFieldModifier.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 5).stroke())
            .cornerRadius(10)
            .padding(.vertical, 5)
            .font(.subheadline)
            .padding(.horizontal, 24)
    }
}
