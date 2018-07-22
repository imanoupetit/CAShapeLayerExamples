//
//  ViewController3.swift
//  TimerButtonApp
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

// Source: https://www.objc.io/issues/12-animations/animating-custom-layer-properties/

import UIKit

class ViewController3: UIViewController {

    let clock = ClockShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.layer.addSublayer(clock)
        // Following will center layer in it's super layer
        clock.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)

        let barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(advanceByTenMinutes))
        navigationItem.rightBarButtonItem = barButton
    }

    @objc func advanceByTenMinutes(_ sender: UIBarButtonItem) {
        clock.update(by: 10)
    }

}
