//
//  Photo.swift
//  ImageSearcher
//
//

import Foundation

public class Photo: Codable {
    
    public let id: Int
    public let pageURL: String?
    public let tags: String?
    public let previewURL: URL
    public let largeImageURL: URL
    public let downloads: Int?
    public let likes: Int?
    public let comments: Int?
}
