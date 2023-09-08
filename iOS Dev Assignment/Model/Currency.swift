//
//  Currency.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 19.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import Foundation

class Currency {
    let name: String
    let longName: String
    let factorToGBP: Double
    
    init(name: String, longName: String, factorToGBP: Double) {
        self.name = name
        self.longName = longName
        self.factorToGBP = factorToGBP
    }
}