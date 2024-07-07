//
//  SettingsView.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var user: User
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.colorScheme) var colorScheme

    @State private var expandedOption: SettingsOptions = .none
    @State private var showAppearancePicker = false
    @State private var showBiometricsPicker = false
    
    enum SettingsOptions {
        case appearance, biometrics, none
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.bottom, 24)

                VStack(alignment: .leading) {
                    
                    if (expandedOption == .appearance) {
                        Text("Appearance")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Button(action: {
                            showAppearancePicker = true
                        }) {
                            HStack {
                                Text(viewModel.appearanceMode.rawValue)
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
                        .sheet(isPresented: $showAppearancePicker) {
                            Picker("Select Appearance", selection: $viewModel.appearanceMode) {
                                ForEach(SettingsViewModel.AppearanceMode.allCases) { mode in
                                    Text(mode.rawValue).tag(mode)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                        }
                    } else {
                        CollapsedPickerView(title: "Appearance", description: viewModel.appearanceMode.rawValue)
                    }
                }
                .modifier(CollapsableSearchViewModifier())
                .frame(height: expandedOption == .appearance ? 120 : 64)
                .onTapGesture {
                    withAnimation(.snappy) {
                        expandedOption = expandedOption == .appearance ? .none : .appearance
                    }
                }
                
                VStack(alignment: .leading) {
                    if (expandedOption == .biometrics) {
                        Text("Biometrics")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Button(action: {
                            showBiometricsPicker = true
                        }) {
                            HStack {
                                Text(viewModel.useBiometrics ? "On" : "Off")
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
                        .sheet(isPresented: $showBiometricsPicker) {
                            Picker("Use Biometrics", selection: $viewModel.useBiometrics) {
                                Text("On").tag(true)
                                Text("Off").tag(false)
                            }
                            .pickerStyle(WheelPickerStyle())
                            .padding()
                        }
                    } else {
                        CollapsedPickerView(title: "Biometrics", description: viewModel.useBiometrics ? "On" : "Off")
                    }
                 }
                .modifier(CollapsableSearchViewModifier())
                .frame(height: expandedOption == .biometrics ? 120 : 64)
                .onTapGesture {
                    withAnimation(.snappy) {
                        expandedOption = expandedOption == .biometrics ? .none : .biometrics
                    }
                }

                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        debugPrint("Log Out")
                        AuthService.shared.logout()
                    }, label: {
                        Text("Logout")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    })
                }
            }
            .padding()
            .onChange(of: viewModel.appearanceMode) { _ in
                updateAppearance()
            }
        }
    }

    private func updateAppearance() {
        switch viewModel.appearanceMode {
        case .light:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        case .dark:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        case .system:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
