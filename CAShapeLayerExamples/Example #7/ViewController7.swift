//
//  ViewController7.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 23/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

// Source: https://www.youtube.com/watch?v=lYVazkkjOb8&t=38s

import UIKit

class ViewController7: UIViewController {

    let shapeLayer = CAShapeLayer()
    let progressRingLayer = CAShapeLayer()
    let pulseLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Observe when app enters foreground state
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        // If startAngle is set to 0, animation will start from the eastern point of the circle
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)

        pulseLayer.path = circularPath.cgPath
        pulseLayer.fillColor = UIColor.orange.withAlphaComponent(0.2).cgColor
        view.layer.addSublayer(pulseLayer)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.magenta.withAlphaComponent(0.8).cgColor
        shapeLayer.lineWidth = 10
        view.layer.addSublayer(shapeLayer)

        progressRingLayer.path = circularPath.cgPath
        progressRingLayer.fillColor = UIColor.clear.cgColor
        progressRingLayer.strokeColor = UIColor.purple.cgColor
        progressRingLayer.lineCap = CAShapeLayerLineCap.round
        progressRingLayer.lineWidth = 10
        progressRingLayer.strokeEnd = 0
        view.layer.addSublayer(progressRingLayer)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lauchTimer))
        view.addGestureRecognizer(gestureRecognizer)

        animatePulse()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        shapeLayer.frame = view.layer.bounds
        pulseLayer.frame = view.layer.bounds
        progressRingLayer.frame = view.layer.bounds
    }

    func animatePulse() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.toValue = 1.2
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        pulseLayer.add(pulseAnimation, forKey: "Pulse")
    }

    @objc func lauchTimer(_ sender: UIButton) {
        let ringAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        ringAnimation.duration = 2
        ringAnimation.toValue = 1
        ringAnimation.fillMode = CAMediaTimingFillMode.forwards
        ringAnimation.isRemovedOnCompletion = false // animation.fillMode must be set to .forwards to make this line work
        progressRingLayer.add(ringAnimation, forKey: "Progress")
    }

    @objc func handleEnterForeground() {
        // Recreate a pulse animation
        animatePulse()
    }

}
