//
//  User.swift
//  newswiftuiproj
//
//  Created by Sequoia on 07/08/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
