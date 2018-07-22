//
//  ViewController.swift
//  replicator
//
//  Created by Imanou on 07/08/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

/*
 Source: http://ronnqvi.st/custom-activity-indicators-using-a-replicator-layer#fnref:1
 */

import UIKit

class ViewController12: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let customIndicatorView = CustomIndicatorView(frame: CGRect(x: 100, y: 100, width: 160, height: 160))
        view.addSubview(customIndicatorView)
    }

}

class CustomIndicatorView: UIView {

    let replicatorLayer = CAReplicatorLayer()
    let replicas = 12
    let defaultDuration: CFTimeInterval = 1
    let tileWidth: CGFloat = 5
    let tileHeight: CGFloat = 20
    let defaultSpread: CGFloat = 35
    let hudSide: CGFloat = 160

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .red

        let tileLayer = CALayer()
        tileLayer.frame = CGRect(x: 0, y: 0, width: tileWidth, height: tileHeight)
        tileLayer.backgroundColor = UIColor.white.cgColor
        tileLayer.cornerRadius = tileWidth / 2
        tileLayer.position = CGPoint(x: hudSide / 2, y: hudSide / 2 + defaultSpread)

        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: hudSide, height: hudSide)
        replicatorLayer.cornerRadius = 10
        replicatorLayer.backgroundColor = UIColor.orange.cgColor
        replicatorLayer.position = CGPoint(x: frame.midX, y: frame.midX)

        let angle = CGFloat.pi * 2 / CGFloat(replicas)
        replicatorLayer.instanceCount = replicas
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)

        replicatorLayer.addSublayer(tileLayer)
        layer.addSublayer(replicatorLayer)

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        opacityAnimation.repeatCount = .infinity
        opacityAnimation.duration = defaultDuration

        replicatorLayer.instanceDelay = defaultDuration / CFTimeInterval(replicas)
        tileLayer.add(opacityAnimation, forKey: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
