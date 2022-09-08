//
//  ImageViewCell.swift
//  ImageSearcher
//
//

import UIKit
import Kingfisher

struct ImageViewCellModel {
    let imageURL: URL?
    let description: String?
}

class ImageViewCell: UICollectionViewCell {
    static let Identifier = "ImageViewCell"
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: ImageViewCellModel? {
        didSet {
            drawCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        background.addBorderAndColor(color: .white, width: 1, corner_radius: 8, clipsToBounds: true)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressGesture(_:)))
        self.imageView.addGestureRecognizer(longPressGesture)
    }

    func drawCell() {
        if let model = model {
            descriptionLabel.text = model.description
            imageView.kf.setImage(with: model.imageURL)
        }
    }
   
    @objc func didLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.4) { [weak descriptionView] in
            descriptionView?.alpha = sender.state == .began ? 0.0 : 1.0
        }
    }
}
