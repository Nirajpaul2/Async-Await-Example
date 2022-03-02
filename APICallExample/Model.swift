//
//  Model.swift
//  APICallExample
//
//  Created by Purplle on 01/03/22.
//

import Foundation

// MARK: - UserDatum
struct UserData: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
