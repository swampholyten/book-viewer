//
//  MapRowView.swift
//  BookViewer
//
//  Created by junkai ji on 07/07/24.
//

import SwiftUI

struct MapRowView: View {
    let icon: String
    let title: String
    @Binding var value: String
    var buttonAction: () -> Void

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 40)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.footnote)
                        .padding(.vertical, 4)
                    
                    Text(value)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    buttonAction()
                }, label: {
                    Image(systemName: "location.fill")
                })
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

//#Preview {
//    MapRowView(icon: "map.fill", title: "Location", value: .constant("Cesena"), buttonAction: {})
//}
