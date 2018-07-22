//
//  PopView.swift
//  TimerButtonApp
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .magenta
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

        let lineShapeLayer = ProgressShapeLayer()
        lineShapeLayer.position = CGPoint(x: 0, y: frame.height / 2)
        layer.addSublayer(lineShapeLayer)
        lineShapeLayer.animate()
    }

}
