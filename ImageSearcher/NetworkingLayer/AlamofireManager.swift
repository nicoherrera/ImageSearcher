//
//  APIManager.swift
//  ImageSearcher
//
//

import Foundation
import Alamofire


public class AlamofireManager {
    
    class func call<T>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?) -> Void) where T: Codable {
        
        AF.request(type.url, method: type.httpMethod, parameters: params, encoding: type.encoding, headers: nil).responseDecodable(of: T.self) { data in
            
            if let respData = data.data {
                let response = String(data: respData, encoding: .utf8)
                #if DEBUG
                debugPrint("Response : \(response ?? "No response data")")
                #endif
            }
            
            switch data.result {
                    
                case .success(_):
                    let decoder = JSONDecoder()
                    if let jsonData = data.data {
                        do {
                            let result = try decoder.decode(T.self, from: jsonData)
                            handler(result, nil)
                        } catch let error {
                            print(error)
                            handler(nil, nil)
                        }
                    }
                case .failure(_):
                    handler(nil, AlamofireManager.parseApiError(data: data.data))
            }
        }
    }
    
    private static func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data,
            let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            let title = error.key ?? "Error"
            let errorAlert = AlertMessage(title: title, body: error.message)
            return errorAlert
        }
        return AlertMessage(title: "Ups!", body: "An unexpected error occurred, please try again")
    }
}
