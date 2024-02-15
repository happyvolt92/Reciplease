//
//  UIImageView.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//    
//

import UIKit

extension UIImageView {
    
    // method to add black gradient layout on TableViewCell
    func addBlackGradientLayerInForeground() {
        let gradient = CAGradientLayer()
        
        gradient.frame = frame
        gradient.locations = [0.0, 1.0]
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.opacity = 0.75
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    // method to remove black gradient layout on TableViewCell
    func removeAllGradientLayerInForeground() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
}
