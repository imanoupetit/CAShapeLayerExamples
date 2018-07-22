//
//  ViewController10.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 04/08/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

/*
  Source: - [Algolia / John Sundell - "Beyond Animations with Core Animation"](https://www.youtube.com/watch?v=J-rruNKcY0Y)
 */

import UIKit

class ViewController10: UIViewController {

    let activityIndicatorView = ActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        activityIndicatorView.animate()
    }

}

class ActivityIndicatorView: UIView {

    let shape = CAShapeLayer()
    let replicatorLayer = CAReplicatorLayer()
    let instanceCount = 20

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.backgroundColor = UIColor.white.cgColor

        shape.frame.size = CGSize(width: 10, height: 50)
        shape.anchorPoint = CGPoint(x: 0.5, y: 1)

        shape.path = CGPath(ellipseIn: shape.frame, transform: nil)
        shape.fillColor = UIColor.lightGray.cgColor

        replicatorLayer.instanceCount = instanceCount

        let fullCircle = CGFloat.pi * 2
        let angle = fullCircle / CGFloat(replicatorLayer.instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)

        replicatorLayer.bounds.size = CGSize(width: shape.frame.height * .pi, height: shape.frame.height)
        replicatorLayer.addSublayer(shape)
        layer.addSublayer(replicatorLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 250)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        replicatorLayer.frame.origin = CGPoint(x: bounds.width / 2 - replicatorLayer.bounds.width / 2, y: bounds.height / 2 - replicatorLayer.bounds.height / 2)
    }

    func animate() {
        let fadeOutAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 1
        fadeOutAnimation.repeatCount = Float.greatestFiniteMagnitude
        shape.add(fadeOutAnimation, forKey: nil)
        replicatorLayer.instanceDelay = fadeOutAnimation.duration / CFTimeInterval(instanceCount)
    }

}
