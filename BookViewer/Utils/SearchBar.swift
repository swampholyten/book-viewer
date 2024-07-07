//
//  SearchBar.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct SearchBar: View {
    
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.searchText.isEmpty ? "Search" : viewModel.searchText)
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Text("\(viewModel.searchText.isEmpty ? "A Keyword - " : "")\(viewModel.selectedCountry.isEmpty ? "A Country" : viewModel.selectedCountry) - \(viewModel.selectedLanguage.isEmpty ? "A Language" : viewModel.selectedLanguage)")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 5).stroke())
        .cornerRadius(10)
        .padding(.vertical, 5)
        .padding()
    }
}
