//
//  PulsingLayer.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 23/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class PulsingLayer: CALayer {

    var animationGroup = CAAnimationGroup()
    let initialPulseScale: Float = 0
    let nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = .infinity

    init(numberOfPulses: Float = .infinity, radius: CGFloat, position: CGPoint) {
        self.numberOfPulses = numberOfPulses
        self.radius = radius

        super.init()

        opacity = 0
        self.position = position
        bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        cornerRadius = radius

        setupAnimationGroup()
        add(animationGroup, forKey: "pulse")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = initialPulseScale
        scaleAnimation.toValue = 1
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }

    private func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        return opacityAnimation
    }

    func setupAnimationGroup() {
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses

        animationGroup.timingFunction = CAMediaTimingFunction(name: .default)
        animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }

}
