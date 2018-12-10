//
//  UIView.swift
//  TeamProject
//
//  Created by David G Chopin on 11/6/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?) -> Void {
        self.applyGradient(colours: colours, locations: nil, cornerRadius: cornerRadius)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, cornerRadius: CGFloat?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        
        if cornerRadius != nil {
            gradient.cornerRadius = cornerRadius!
        }
    }
}
