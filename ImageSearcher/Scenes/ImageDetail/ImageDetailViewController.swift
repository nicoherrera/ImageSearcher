//
//  ImageDetailViewController.swift
//  ImageSearcher
//
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var singleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    var model: ImageDetailViewModel?
    
    var statusBarHidden = false
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.isHidden = false
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        enterFullScreenMode(false)
    }
    
    func render() {
        if let model = model {
            imageView.kf.indicatorType = .activity
            (imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
            imageView.kf.setImage(with: model.image.largeImageURL, options: [.transition(.fade(0.2))])
            descriptionLabel.text = model.image.tags
        }
    }
    
    func showHideNavigationBar(isHidden: Bool) {
        self.statusBarHidden = isHidden
        self.navigationController?.navigationBar.isHidden = isHidden
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func enterFullScreenMode(_ fullScreen: Bool) {
        if !fullScreen {
            self.showHideNavigationBar(isHidden: false)
        }
        UIView.animate(withDuration: 0.4) {
            let alpha = fullScreen ? 0.0 : 1.0
            self.descriptionView.alpha = alpha
            self.navigationController?.navigationBar.alpha = alpha
        } completion: { finished in
            if finished && fullScreen {
                self.showHideNavigationBar(isHidden: fullScreen)
            }
        }
    }

    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        enterFullScreenMode(descriptionView.alpha == 1)
    }
    
    @IBAction func dobleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let zoomInFactor = 2.0
        // zoom out if it bigger than the scale factor after double-tap scaling. Else, zoom in
        if scrollView.zoomScale >= scrollView.minimumZoomScale * zoomInFactor - 0.01 {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let center = gestureRecognizer.location(in: gestureRecognizer.view)
            let zoomRect = zoomRectForScale(zoomInFactor * scrollView.minimumZoomScale, center: center)
            scrollView.zoom(to: zoomRect, animated: true)
            enterFullScreenMode(true)
        }
    }
    
    private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        
        // the zoom rect is in the content view's coordinates.
        // at a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
        // as the zoom scale decreases, so more content is visible, the size of the rect grows.
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width  = scrollView.frame.size.width  / scale
        
        // choose an origin so as to get the right center.
        zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0)
        zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0)
        
        return zoomRect
    }
}

//MARK: - UIScrollViewDelegate
extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        enterFullScreenMode(true)
    }
}
//MARK: - Navigation
extension ImageDetailViewController {
    static func instantiate(with viewModel: ImageDetailViewModel) -> ImageDetailViewController {
        let vc: ImageDetailViewController = UIStoryboard
            .storyboard(name: "ImageDetail")
            .initialViewController()
        vc.model = viewModel
        return vc
    }
}
