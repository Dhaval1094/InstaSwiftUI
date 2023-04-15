//
//  SearchResponse.swift
//  InstaSwiftUI
//
//  Created by Gwl on 15/04/23.
//

import Foundation

// MARK: - Welcome
struct SearchResponse: Codable, Hashable {
    let page, perPage: Int?
    let photos: [Photo]?
    let totalResults: Int?
    let nextPage: String?
}

// MARK: - Photo
struct Photo: Codable, Hashable {
    let id, width, height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: Src?
    let liked: Bool?
    let alt: String?
}

// MARK: - Src
struct Src: Codable, Hashable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?
}
