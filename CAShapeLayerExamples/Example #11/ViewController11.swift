//
//  ViewController11.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 04/08/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

/*
 Source: CAReplicatorLayer's instanceDelay documentation
 */

class ViewController11: UIViewController {

    let animatedView = AnimatedView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(animatedView)

        animatedView.translatesAutoresizingMaskIntoConstraints = false
        animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animatedView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        animatedView.animate()
    }

}

class AnimatedView: UIView {

    let replicatorLayer = CAReplicatorLayer()
    let circleLayer = CALayer()
    let instanceCount = 30

    override init(frame: CGRect) {
        super.init(frame: frame)

        circleLayer.frame = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
        circleLayer.backgroundColor = UIColor.blue.cgColor
        circleLayer.cornerRadius = 5
        circleLayer.position = CGPoint(x: 0, y: 50)
        replicatorLayer.addSublayer(circleLayer)

        replicatorLayer.instanceCount = instanceCount
        let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        layer.addSublayer(replicatorLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate() {
        let fadeOutAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 1
        fadeOutAnimation.repeatCount = Float.greatestFiniteMagnitude
        circleLayer.add(fadeOutAnimation, forKey: nil)
        replicatorLayer.instanceDelay = fadeOutAnimation.duration / CFTimeInterval(instanceCount)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        replicatorLayer.frame.origin = CGPoint(x: bounds.width / 2 - replicatorLayer.bounds.width / 2, y: bounds.height / 2 - replicatorLayer.bounds.height / 2)
    }

}
