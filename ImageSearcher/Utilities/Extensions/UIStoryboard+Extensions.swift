//
//  UIStoryboard+Extensions.swift
//  ImageSearcher
//
//

import UIKit

extension UIStoryboard {
    
    static func storyboard(name: String) -> UIStoryboard {
        UIStoryboard(name: name, bundle: nil)
    }
    
    func viewController<T>(named name: String) -> T {
        guard let vc = instantiateViewController(identifier: name) as? T else {
            fatalError("View controller identified as \(name) not found")
        }
        
        return vc
    }
    
    func initialViewController<T>() -> T {
        guard let vc = instantiateInitialViewController() as? T else {
            fatalError("Initial ViewController not found in \(String(describing: self))")
        }
        
        return vc
    }
}
