//
//  UnImage.swift
//  Ambience
//
//  Created by Kovs on 14.06.2023.
//

import Foundation

// MARK: - Model
struct UnImageModel: Codable {
    let total: Int
    let total_pages: Int
    let results: [UnImage]
}

// MARK: - Unsplash image model
struct UnImage: Codable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let likes: Int
    let liked_by_user: Bool
    let description: String?
    let user: UnUser
    let current_user_collections: [String]
    let urls: UnImageURL
    let links: UnImageLinks
}

// MARK: - Unsplash user model
struct UnUser: Codable {
    let id: String
    let username: String
    let name: String
    let first_name: String
    let last_name: String
    let instagram_username: String?
    let twitter_username: String?
    let portfolio_url: String?
    let profile_image: UnProfileImage
    let links: UnUserLinks

}

// MARK: - Profile image
struct UnProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

// MARK: - User links
struct UnUserLinks: Codable {
    let `self`: String
    let html: String
    let photos: String
    let likes: String
}

// MARK: - ImageURL
struct UnImageURL: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

// MARK: - Image links
struct UnImageLinks: Codable {
    let `self`: String
    let hmtl: String
    let download: String
}
