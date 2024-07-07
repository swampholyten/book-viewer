//
//  CompleteSignUpView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Welcome to Book Viewer, \(viewModel.name)")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            
            
            Text("Click below to complete registration and start using Book Viewer")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Complete Sign Up")
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

    }
}

#Preview {
    CompleteSignUpView()
}
