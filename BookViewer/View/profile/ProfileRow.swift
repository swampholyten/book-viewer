//
//  ProfileRow.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI

struct ProfileRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                Text(value)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 5).stroke())
        .cornerRadius(10)
        .padding(.vertical, 5)
    }
}

#Preview {
    ProfileRow(icon: "circle", title: "Name", value: "Junkai")
}
