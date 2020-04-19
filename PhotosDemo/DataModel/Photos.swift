//
//  Photos.swift
//  PhotosDemo
//
//  Created by Gamze Güven on 20.04.2020.
//  Copyright © 2020 Gamze Güven. All rights reserved.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    var meta: Meta?
    var result: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

// MARK: - Meta
struct Meta: Codable {
    var success: Bool
    var code: Int
    var message: String
    var totalCount, pageCount, currentPage, perPage: Int
    var rateLimit: RateLimit
}

// MARK: - RateLimit
struct RateLimit: Codable {
    var limit, remaining, reset: Int
}

// MARK: - Result
struct Result: Codable {
    var id, albumID, title: String
    var url, thumbnail: String
    var links: Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case title, url, thumbnail
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    var linksSelf, edit: Edit
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case edit
    }
}

// MARK: - Edit
struct Edit: Codable {
    var href: String
}

