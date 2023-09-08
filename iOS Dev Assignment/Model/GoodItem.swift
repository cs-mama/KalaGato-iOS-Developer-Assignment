//
//  Good.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 19.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import UIKit

class GoodItem : Hashable {
    let name: String
    let priceInGBP: Double
    let containerName: String
    let image: UIImage?
    
    init(name: String, priceInGBP: Double, containerName: String, image: UIImage?) {
        self.name = name
        self.priceInGBP = priceInGBP
        self.containerName = containerName
        self.image = image
    }
    
    convenience init(name: String, containerName: String, priceInGBP: Double) {
        self.init(name: name, priceInGBP: priceInGBP, containerName: containerName, image: nil)
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return "\(name) \(priceInGBP)".hashValue
    }
}

// MARK: - Equatable

func ==(lhs: GoodItem, rhs: GoodItem) -> Bool {
    return lhs.hashValue == rhs.hashValue
}