//
//  PopView.swift
//  TimerButtonApp
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class PopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = false // default
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeAllAnimations()
                sublayer.removeFromSuperlayer()
            }
        }

        // Create 6 lines and rotate them around the center
        for number in 1 ... 6 {
            let lineShapeLayer = LineShapeLayer()
            lineShapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            lineShapeLayer.transform = CATransform3DMakeRotation(.pi * 2 / 6 * CGFloat(number), 0, 0, 1)
            layer.addSublayer(lineShapeLayer)
            lineShapeLayer.animate()
        }

        // Slightly rotate the angle of the view so it changes slightly per instance
        let minOffset: UInt32 = 0
        let maxOffset: UInt32 = 200
        let randomValue = arc4random_uniform(maxOffset - minOffset) + minOffset
        let rotation = CGFloat(randomValue) / 100
        transform = CGAffineTransform(rotationAngle: rotation)
    }

}
