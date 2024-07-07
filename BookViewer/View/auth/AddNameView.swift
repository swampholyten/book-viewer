//
//  AddEmailView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct AddNameView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Add your name")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this name to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Name", text: $viewModel.name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .modifier(TextFieldModifier())
            
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(colorScheme == .light ? Color.black : Color.white)
                    .foregroundStyle(colorScheme == .light ? Color.white : Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.white)
            }
            .padding(.vertical)
            

            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    AddNameView()
}
