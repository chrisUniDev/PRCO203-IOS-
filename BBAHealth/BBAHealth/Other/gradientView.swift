//
//  gradientView.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 20/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//



import Foundation

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect){
        let colors = [firstColor.cgColor, secondColor.cgColor] as CFArray
        let endRadius = min(frame.width, frame.height) / 1.2
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        
    }
}
