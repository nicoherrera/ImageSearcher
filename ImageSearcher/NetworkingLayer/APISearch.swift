//
//  APISearch.swift
//  ImageSearcher
//
//

import Foundation
import Alamofire


enum SearchEndpoint {
    case search
}

extension SearchEndpoint: EndPointType {
    
    var baseURL: String {
        return Config.Pixbay.baseURL
    }
    
    var path: String { "" }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .search:
                return .get
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
