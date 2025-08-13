//
//  APIService.swift
//  newswiftuiproj
//
//  Created by Sequoia on 07/08/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
}
