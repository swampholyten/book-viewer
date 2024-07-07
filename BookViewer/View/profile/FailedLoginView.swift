//
//  FailedLoginView.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI

struct FailedLoginView: View {

    var body: some View {
        VStack(spacing: 20) {
            Text("Authentication Failed")
                .font(.title)
                .fontWeight(.bold)

            Text("Biometric authentication failed. Please try again.")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .foregroundStyle(.gray)

        }
        .padding()
    }
}

#Preview {
    FailedLoginView()
}
