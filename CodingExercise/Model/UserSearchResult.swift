//
//  UserSearchResult.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

struct UserSearchResult: Codable {
    let username: String
    let name: String
    let id: Int
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case avatarUrl = "avatar_url"
        case id, username
    }
}

struct SearchResponse: Codable {
    let ok: Bool
    let error: String?
    let users: [UserSearchResult]
}
