//
//  ViewController12.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 06/08/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

/*
 Source: http://ios-sdk.blogspot.com/2012/01/cabasicanimation.html
 */

class ViewController13: UIViewController {

    let redView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        redView.bounds.size = CGSize(width: 100, height: 100)
        redView.backgroundColor = .red
        view.addSubview(redView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(rotate))
    }

    override func viewDidLayoutSubviews() {
        redView.center = CGPoint(x: view.center.x, y: view.center.y)
    }

    @objc func rotate(_ sender: UIBarButtonItem) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = 0
        animation.toValue = Float.pi / 3
        redView.layer.add(animation, forKey: "Rotate Layer")
    }

}
