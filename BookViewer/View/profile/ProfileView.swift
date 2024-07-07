//
//  ProfileView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    
    @EnvironmentObject var user: User
    @StateObject private var viewModel = ProfileViewModel()


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Profile of " + user.name)
                        .font(.title)
                        .fontWeight(.light)
                        .padding(.bottom, 24)
                    
                    ProfileRow(icon: "person.fill", title: "Name", value: user.name)
                    ProfileRow(icon: "person.text.rectangle.fill", title: "Biography", value: user.bio ?? "")
                    ProfileRow(icon: "mappin.and.ellipse", title: "Location", value: viewModel.cityName)
                    ProfileRow(icon: "book.pages.fill", title: "Saved Books", value: "\(viewModel.savedBookCount) / \(viewModel.totalBooks)")
                    
                    BookStatusChartView()
                        .environmentObject(viewModel)

                    Spacer()
                    
                }
                .padding()
                .navigationBarItems(trailing: NavigationLink(destination: EditProfileView(profileViewModel: viewModel)) {
                    Text("Edit")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                })
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchSavedBookCount(for: user)
                viewModel.latitude = user.latitude!
                viewModel.longitude = user.longitude!
            }
        }
    }

}

//#Preview {
//    ProfileView()
//}
