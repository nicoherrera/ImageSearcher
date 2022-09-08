//
//  EndpointType.swift
//  ImageSearcher
//
//

import Foundation
import Alamofire

protocol EndPointType {
    
    // MARK: - Vars & Lets
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}
