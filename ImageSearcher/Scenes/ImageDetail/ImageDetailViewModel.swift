//
//  ImageDetailViewModel.swift
//  ImageSearcher
//
//

import Foundation

struct ImageDetailViewModel {
    let image: Photo
    let images: [Photo]
    let index: Int
    
    init(_ image: Photo, images: [Photo], index: Int = 0) {
        self.image = image
        self.images = images
        self.index = index
    }
}
