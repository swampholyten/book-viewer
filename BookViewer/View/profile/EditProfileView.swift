import SwiftUI
import MapKit

struct EditProfileView: View {
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var profileViewModel: ProfileViewModel
    @StateObject private var viewModel = SettingsViewModel()
    @State private var isAuthenticated = false

    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var password: String = ""
    
    @State private var region: MKCoordinateRegion
    

    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: profileViewModel.latitude, longitude: profileViewModel.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        if isAuthenticated {
            withAnimation(.smooth) {
                VStack {
                    Text("Edit Profile")
                        .font(.title)
                        .fontWeight(.light)
                        .padding(.bottom, 24)
                        
                    EditProfileRowView(imageName: "person.fill", placeholder: "Name", isPassword: false, text: $name)
                    EditProfileRowView(imageName: "lock.fill", placeholder: "Password", isPassword: true, text: $password)
                    EditProfileRowView(imageName: "person.text.rectangle.fill", placeholder: "Biography", isPassword: false, text: $bio)
//                    EditProfileRowView(imageName: "mappin.and.ellipse", placeholder: "Location", isPassword: false, text: $profileViewModel.cityName)

                    MapRowView(icon: "mappin.and.ellipse", title: "Location", value: $profileViewModel.cityName) {
                        profileViewModel.requestCurrentLocation()
                    }
                    
                    
                    if profileViewModel.isLoadingLocation {
                        ProgressView("Fetching location...")
                            .padding()
                    } else {
                        Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .onChange(of: region.center) { newCenter in
                                profileViewModel.latitude = newCenter.latitude
                                profileViewModel.longitude = newCenter.longitude
                            }
                            .onReceive(profileViewModel.$currentLocation) { location in
                                if let location = location {
                                    region.center = location
                                }
                            }
                    }

                    Spacer()
                    
                }
                .padding()
                .onAppear {
                    name = user.name
                    bio = user.bio ?? ""
                    password = user.password
                    profileViewModel.saveTemporaryLocation(latitude: profileViewModel.latitude, longitude: profileViewModel.longitude)
                    region.center = CLLocationCoordinate2D(latitude: profileViewModel.latitude, longitude: profileViewModel.longitude)
                }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            user.name = name
                            user.bio = bio
                            user.password = password
                            user.latitude = region.center.latitude
                            user.longitude = region.center.longitude
                            dismiss()
                            NotificationCenter.default.post(name: .changesSaved, object: nil)
                        }, label: {
                            Text("Save")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        })
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            user.latitude = profileViewModel.getTemporaryLatitude()
                            user.longitude = profileViewModel.getTemporaryLatitude()
                            profileViewModel.resetCity()
                            dismiss()
                        }, label: {
                            Text("Cancel")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        })
                    }
                }
            }
        } else {
            Text("")
                .onAppear {
                    authenticateUser()
                }
                .navigationBarBackButtonHidden(true)
        }
    }

    private func authenticateUser() {
        if viewModel.useBiometrics {
            viewModel.authenticateUser { success in
                if success {
                    isAuthenticated = true
                } else {
                    dismiss()
                }
            }
        } else {
            isAuthenticated = true
        }
    }
}
