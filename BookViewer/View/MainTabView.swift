//
//  MainTabView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI

struct MainTabView: View {

    @State private var notificationMessage = ""

    var body: some View {
        
        TabView {
            ExploreView()
                .tabItem { Label("Explore", systemImage: "magnifyingglass") }
            
            FavouriteView()
                .tabItem { Label("Favorite", systemImage: "heart") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .tint(.primary)
    }
}

//#Preview {
//    MainTabView()
//}
