//
//  APIManager.swift
//  ImageSearcher
//
//

import Foundation
import RxSwift

public class APIManager {
    
    public class func searchImages(query: String, page: Int) -> Observable<PhotoResult> {
        
        return Observable<PhotoResult>.create { observer in
            
            let params: [String:Any] = [
                "q": query,
                "page": page,
                "key": Config.Pixbay.apiKey
            ]
            
            AlamofireManager.call(type: SearchEndpoint.search, params: params) { (response: PhotoResult?, alert) in
                if let response = response {
                    observer.onNext(response)
                }
                else if let error = alert {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
