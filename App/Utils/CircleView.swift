//
//  CircleView.swift
//  App
//
//  Created by Ayman Salah on 9/7/20.
//  Copyright © 2020 initium. All rights reserved.
//

import UIKit

class CircleView : UIView {
    private var shape = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        UIColor(named: "Header")!.setFill()
        UIRectFill(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        
        context.move(to:  CGPoint(x: 0,y: bounds.size.height))
        context.addQuadCurve(to: CGPoint(x: bounds.size.width, y: bounds.size.height), control: CGPoint(x: bounds.size.width / 2, y: 0))
        context.closePath()
        context.setFillColor(UIColor.lightGray.cgColor)
        context.fillPath()
        
    }
    
    
}
