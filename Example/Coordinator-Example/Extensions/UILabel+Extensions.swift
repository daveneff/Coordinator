//  UILabel+Extensions.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

extension UILabel {
    
    enum Size: Int {
        case title = 50
        case paragraph = 21
        
        var cgFloat: CGFloat {
            return CGFloat(rawValue)
        }
    }
    
    func setDefaultStyle(size: UILabel.Size, weight: UIFont.Weight) {
        font = UIFont.systemFont(ofSize: size.cgFloat, weight: weight)
    }
    
}
