//
//  ContentView.swift
//  BookViewer
//
//  Created by junkai ji on 05/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var books: [Book]
    @State private var notificationMessage = ""
    @StateObject private var notificationViewModel = NotificationViewModel.shared

    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()

    var body: some View {
        ZStack {
            
            if viewModel.currentUser == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser {
                MainTabView()
                    .environmentObject(currentUser)
            }
            
            VStack {
                if notificationViewModel.showNotification {
                    NotificationView(message: notificationViewModel.notificationMessage, backgroundColor: notificationViewModel.backgroundColor)
                        .transition(.opacity)
                        .zIndex(1)
                }
                Spacer()
            }
            
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .userLoggedIn, object: nil, queue: .main) { _ in
                notificationViewModel.showNotification(message: "Welcome to Book Viewer", backgroundColor: .green)
            }
            
            NotificationCenter.default.addObserver(forName: .userFailedLoggedIn, object: nil, queue: .main) { _ in
                notificationViewModel.showNotification(message: "Wrong Name or Password", backgroundColor: .green)
            }
            
            NotificationCenter.default.addObserver(forName: .bookSaved, object: nil, queue: .main) { _ in
                notificationViewModel.showNotification(message: "Book Saved", backgroundColor: .blue)
            }

            NotificationCenter.default.addObserver(forName: .bookRemoved, object: nil, queue: .main) { _ in
                notificationViewModel.showNotification(message: "Book Removed", backgroundColor: .red)
            }

            NotificationCenter.default.addObserver(forName: .changesSaved, object: nil, queue: .main) { _ in
                notificationViewModel.showNotification(message: "Changes Saved", backgroundColor: .orange)
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
        
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
