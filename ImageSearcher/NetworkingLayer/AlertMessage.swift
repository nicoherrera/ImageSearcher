//
//  AlertMessage.swift
//  ImageSearcher
//
//

import Foundation
struct AlertMessage: Error {
    let title: String
    let body: String
    
    init(title: String, body: String) {
        self.body = body
        self.title = title
    }
}
