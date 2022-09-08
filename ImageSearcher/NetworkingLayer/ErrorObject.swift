//
//  ErrorObject.swift
//  ImageSearcher
//
//

import Foundation
struct ErrorObject: Codable {
    let message: String
    let key: String?
    let sysMessage: String?
}
