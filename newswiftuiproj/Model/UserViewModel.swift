//
//  UserViewModel.swift
//  newswiftuiproj
//
//  Created by Sequoia on 07/08/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadUsers() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let result = try await APIService.shared.fetchUsers()
                self.users = result
            }
            catch {
                self.errorMessage = "Failed to load users : \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
