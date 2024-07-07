//
//  EditProfileRowView.swift
//  BookViewer
//
//  Created by junkai ji on 07/07/24.
//

import SwiftUI

struct EditProfileRowView: View {
    let imageName: String
    let placeholder: String
    let isPassword: Bool
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .frame(width: 40)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(placeholder)
                    .font(.footnote)
                
                if isPassword {
                    SecureField(placeholder, text: $text)
                        .font(.caption)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 5).stroke())
        .cornerRadius(10)
        .padding(.vertical, 5)
    }
}
