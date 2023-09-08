//
//  GoodCardView.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 20.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import UIKit

class GoodCardCell: UICollectionViewCell {

    @IBOutlet weak var goodNameLabel: UILabel!
    @IBOutlet weak var goodPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var goodImageView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func didMoveToSuperview() {
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
    
    func setImage(image: UIImage?, animated: Bool, delay: Double = 0.0) {
        if image == nil {
            return
        }
        let imageView = PrettyImageView(image: image!, frame: goodImageView.bounds)
        imageView.animationDuration = animated ? (0.8) : (0.0)
        goodImageView.subviews.first?.removeFromSuperview()
        goodImageView.addSubview(imageView)
        if delay > 0 {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                imageView.animate()
            }
        } else {
            imageView.animate()
        }
    }
}
