//
//  LineShapeLayer.swift
//  TimerButtonApp
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

final class ProgressShapeLayer: CAShapeLayer {

    override init() {
        super.init()

        lineWidth = 10
        lineCap = CAShapeLayerLineCap.round
        strokeColor = UIColor.orange.cgColor

        let inset = lineWidth / 2
        let bezPath = UIBezierPath()
        bezPath.move(to: CGPoint(x: inset, y: 0))
        bezPath.addLine(to: CGPoint(x: 200 - inset, y: 0))
        path = bezPath.cgPath
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate() {
        let duration: CFTimeInterval = 1

        let end = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        end.fromValue = 0
        end.toValue = 1
        end.beginTime = 0
        end.duration = duration * 0.75
        end.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        end.fillMode = CAMediaTimingFillMode.forwards

        let begin = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        begin.fromValue = 0
        begin.toValue = 1
        begin.beginTime = duration * 0.15
        begin.duration = duration * 0.85
        begin.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        begin.fillMode = CAMediaTimingFillMode.backwards

        let group = CAAnimationGroup()
        group.animations = [begin, end]
        group.duration = duration

        strokeStart = 1
        add(group, forKey: "animate progress")
    }

}
