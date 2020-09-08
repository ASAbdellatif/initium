//
//  Extensions.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit

extension UIView {
    
    public func roundCorners(radius: CGFloat, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = CGFloat(borderWidth ?? 0)
        self.layer.masksToBounds = true
    }
}

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
