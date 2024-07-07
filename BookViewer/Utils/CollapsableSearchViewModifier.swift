//
//  CollapsableSearchViewModifier.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct CollapsableSearchViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
//            .background(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
//            .shadow(radius: 8)
    }
}

