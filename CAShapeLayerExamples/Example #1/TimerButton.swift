//
//  TimerButton.swift
//  TimerButtonApp
//
//  Created by Imanou on 21/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

final class TimerButton: UIButton {

    private let ringLayer = CAShapeLayer()
    private let circleLayer = CAShapeLayer()

    init() {
        super.init(frame: .zero)

        setTitle("0", for: .normal)

        circleLayer.fillColor = UIColor.orange.cgColor
        layer.addSublayer(circleLayer)

        ringLayer.isHidden = true
        ringLayer.lineWidth = 10
        ringLayer.strokeStart = 0 // default
        ringLayer.strokeEnd = 1 // default
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(ringLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let inset = ringLayer.lineWidth
        circleLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: inset, dy: inset)).cgPath
        ringLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: inset / 2, dy: inset / 2)).cgPath
        circleLayer.frame = bounds
        ringLayer.frame = bounds
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }

    func toggleProgress() {
        if let _ = ringLayer.presentation()?.animation(forKey: "Progress") {
            stopProgress()
        } else {
            animateProgress()
        }
    }

    func reset() {
        stopProgress()
        setTitle("0", for: .normal)
    }

    private func animateProgress() {
        ringLayer.isHidden = false

        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.duration = 3
        animation.fromValue = 0
        animation.toValue = 1
        animation.beginTime = CACurrentMediaTime()
        let completionBlock = {
            // Perform the completion block only if animation has reached its end
            if CACurrentMediaTime() - animation.beginTime >= animation.duration {
                if let displayedString = self.titleLabel?.text, let value = Int(displayedString) {
                    self.setTitle("\(value + 1)", for: .normal)
                }
            }
        }
        // Add completion block before adding animation
        CATransaction.setCompletionBlock(completionBlock)
        ringLayer.add(animation, forKey: "Progress")
        CATransaction.commit()
    }

    private func stopProgress() {
        ringLayer.removeAllAnimations()
        ringLayer.isHidden = true
    }

}
