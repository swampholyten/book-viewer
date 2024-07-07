//
//  LoginView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
//                logo
                
                Text("BOOK VIEWER")
                    .font(.largeTitle)
                    .frame(width: 320, height: 140)
                
//                text fields
                
                VStack {
                    TextField("Enter Your Name", text: $loginViewModel.name)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .modifier(TextFieldModifier())
                        .padding(.vertical, 8)

                    
                    SecureField("Enter Your Password", text: $loginViewModel.password)
                        .modifier(TextFieldModifier())

                }
                
                
//                login button
                
                Button{
                    Task {
                        try await loginViewModel.signIn()
                    }
                } label: {
                    Text("Log In")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 44)
                        .background(colorScheme == .light ? Color.black : Color.white)
                        .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    AddNameView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an Account?")
                        
                        Text("Sign Up")
                    }
                    .font(.footnote)
                    .tint(.primary)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
