//
//  Users.swift
//  newswiftuiproj
//
//  Created by Sequoia on 07/08/25.
//

import SwiftUI

struct Users: View {
    
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            }
            else if let error = viewModel.errorMessage {
                Text(error)
            }
            else {
                List(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline)
                    }
                }
                .navigationTitle("Users")
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}

#Preview {
    Users()
}
