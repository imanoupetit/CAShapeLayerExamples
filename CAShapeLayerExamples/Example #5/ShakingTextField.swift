//
//  ShakingTextField.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 23/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shake() {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: center.x - 4, y: center.y)
        animation.toValue = CGPoint(x: center.x + 4, y: center.y)
        layer.add(animation, forKey: nil)
    }

}
