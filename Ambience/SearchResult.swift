//
//  SearchResult.swift
//  Ambience
//
//  Created by Kovs on 01.07.2023.
//

import Foundation

struct Results: Codable {
    var total: Int
    var results: [ImageResult]
}

struct ImageResult: Codable {
    var id: String
    var description: String?
    var urls: URLs
}

struct URLs: Codable {
    var small: String
}
