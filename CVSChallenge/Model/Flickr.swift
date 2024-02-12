//
//  Flickr.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/9/24.
//


import Foundation

// MARK: - Flickr
public struct Flickr: Codable {
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let generator: String?
    let images: [ImageData]?
    
    enum CodingKeys: String, CodingKey {
        case title, link, description
        case modified, generator
        case images = "items"
    }
}

// MARK: - ImageData
public struct ImageData: Codable, Hashable {
    
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: String?
    let description: String?
    let published: String?
    let author: String?
    let authorId: String?
    let tags: String?

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorId = "author_id"
        case tags
    }
}

// MARK: - Media
struct Media: Codable, Hashable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}
