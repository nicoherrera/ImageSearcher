//
//  PhotoResult.swift
//  ImageSearcher
//
//

import Foundation

public class PhotoResult: Codable {
    public let total: Int
    public let totalHits: Int
    public let images: [Photo]

    
    enum CodingKeys: String, CodingKey {
        case total
        case totalHits
        case images = "hits"
    }
}
