//
//  FilterSearchView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct FilterSearchView: View {
    
    @Binding var show: Bool
    @ObservedObject var viewModel: ExploreViewModel
    @State private var showCountryPicker = false
    @State private var showLanguagePicker = false
    @State private var expandedOption: FilterOptions = .search

    
    let countries = ["All", "Germany", "Italy"]
    let languages = ["All", "English", "Spanish"]
    
    enum FilterOptions {
        case country, language, search, none
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.snappy) {
                        viewModel.updateBooks()
                        show.toggle()
                    }
                }, label: {
                    Text("Close")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                })
                
                Spacer()
                
                if (!viewModel.searchText.isEmpty || !viewModel.selectedLanguage.isEmpty || !viewModel.selectedCountry.isEmpty) {
                    Button("Clear") {
                        viewModel.selectedCountry = "All"
                        viewModel.selectedLanguage = "All"
                        viewModel.searchText = ""
                    }
//                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            
            
            VStack(alignment: .leading) {
                if expandedOption == .search {
                    Text("Search")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                        

                            TextField("Search books...", text: $viewModel.searchText)
                                .font(.subheadline)
                                .autocorrectionDisabled()
                                .onSubmit {
                                    show.toggle()
                                }


                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 5).stroke())
                    .cornerRadius(10)
                    .padding(.vertical, 5)
                } else {
                    CollapsedPickerView(title: "Search", description: viewModel.searchText.isEmpty ? "Your Book" : viewModel.searchText)
                }
            }
            .modifier(CollapsableSearchViewModifier())
            .frame(height: expandedOption == .search ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy) {
                    expandedOption = .search
                }
            }
            
            VStack(alignment: .leading) {
                if expandedOption == .country {
                    Text("Country")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Button(action: {
                        showCountryPicker = true
                    }) {
                        HStack {
                            Text(viewModel.selectedCountry.isEmpty ? "Select Country" : viewModel.selectedCountry)
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showCountryPicker) {
                        Picker("Select Country", selection: $viewModel.selectedCountry) {
                            ForEach(countries, id: \.self) { country in
                                Text(country).tag(country)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .padding()
                    }
                } else {
                    CollapsedPickerView(title: "Country", description: viewModel.selectedCountry.isEmpty ? "All" : viewModel.selectedCountry)
                }
            }
            .modifier(CollapsableSearchViewModifier())
            .frame(height: expandedOption == .country ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy) {
                    expandedOption = .country
                }
            }
            
            VStack(alignment: .leading) {
                if expandedOption == .language {
                    Text("Language")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Button(action: {
                        showLanguagePicker = true
                    }) {
                        HStack {
                            Text(viewModel.selectedLanguage.isEmpty ? "Select Language" : viewModel.selectedLanguage)
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    .sheet(isPresented: $showLanguagePicker) {
                        Picker("Select Language", selection: $viewModel.selectedLanguage) {
                            ForEach(languages, id: \.self) { language in
                                Text(language).tag(language)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .padding()
                    }
                } else {
                    CollapsedPickerView(title: "Language", description: viewModel.selectedLanguage.isEmpty ? "All" : viewModel.selectedLanguage)
                }
            }
            .modifier(CollapsableSearchViewModifier())
            .frame(height: expandedOption == .language ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy) {
                    expandedOption = .language
                }
            }

            
            Spacer()
        }
        .padding()
    }
}

