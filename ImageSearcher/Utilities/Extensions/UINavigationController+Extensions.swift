//
//  UINavigationController+Extensions.swift
//  ImageSearcher
//
//

import UIKit

extension UINavigationController {
    open override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? false
    }
}
