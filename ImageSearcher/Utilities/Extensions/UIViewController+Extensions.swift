//
//  UIViewController+Utility.swift
//  ImageSearcher
//
//


import UIKit
import iProgressHUD

extension UIViewController {
    
    func showAlertMessage(titleStr: String, messageStr: String) {
        let alertController = UIAlertController(title: titleStr,
                                                message: messageStr,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func toggleLoading(enable: Bool, infoText: String? = nil) {
        let iProgressHUD = iProgressHUD.sharedInstance()
        if enable {

            iProgressHUD.boxColor = UIColor.black.withAlphaComponent(0.7)
            iProgressHUD.boxSize = 40
            iProgressHUD.modalColor = .clear
            iProgressHUD.attachProgress(toView: self.view)
            
            self.view.updateCaption(text: infoText ?? "")
            self.view.showProgress()
        } else {
            self.view.dismissProgress()
        }
    }
}
